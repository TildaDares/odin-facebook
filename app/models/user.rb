class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :notifications
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  acts_as_favoritor
  # after_create_commit :add_default_avatar
  # after_create_commit :add_default_header
  after_create_commit :send_confirmation_email
  has_one_attached :avatar
  has_one_attached :header
  validates :username, presence: true, length: { minimum: 1, maximum: 50 }
  validates :bio, length: { maximum: 160 }
  validates :location, length: { maximum: 30 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.username = provider_data.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150x150!').processed
    else
      'avatar.jpg'
    end
  end

  def header_thumbnail
    if header.attached?
      header
    else
      'header.jpg'
    end
  end

  def friend_requests
    inverse_friends - friends
  end

  def mutual_friends
    friends.map { |friend| friend if friend.friends.include?(self) }.compact
  end

  def sent_requests
    friends.map { |friend| friend unless friend.friends.include?(self) }.compact
  end

  def friendship_status(user)
    if friend_requests.include?(user)
      'Accept Request'
    elsif mutual_friends.include?(user)
      'Unfriend'
    elsif sent_requests.include?(user)
      'Cancel Request'
    else
      'Add Friend'
    end
  end

  def send_confirmation_email
    ConfirmationMailer.with(user: self).confirmation_email.deliver_now
  end

  def strangers
    User.all - (friend_requests + mutual_friends + sent_requests)
  end

  # private

  # def add_default_header
  #   unless header.attached?
  #     header.attach(
  #       io: File.open(
  #         Rails.root.join(
  #           'app', 'assets', 'images', 'header.jpg'
  #         )
  #       ), filename: 'header.jpg',
  #       content_type: 'image/jpg'
  #     )
  #   end
  # end

  # def add_default_avatar
  #   unless avatar.attached?
  #     avatar.attach(
  #       io: File.open(
  #         Rails.root.join(
  #           'app', 'assets', 'images', 'avatar.jpg'
  #         )
  #       ), filename: 'avatar.jpg',
  #       content_type: 'image/jpg'
  #     )
  #   end
  # end
end
