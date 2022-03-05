class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :searches, dependent: :destroy

  # sending a request
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # receiving a request
  # inverse friends looks for a user that has my friend_id equal to my id
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  acts_as_favoritor
  after_create_commit :send_confirmation_email
  has_one_attached :avatar
  has_one_attached :header

  validates :username, presence: true, length: { minimum: 1, maximum: 50 }
  validates :bio, length: { maximum: 160 }
  validates :location, length: { maximum: 30 }
  validates :avatar, content_type: [:png, :jpg, :jpeg]
  validates :header, content_type: [:png, :jpg, :jpeg]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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

  def send_confirmation_email
    ConfirmationMailer.with(user: self).confirmation_email.deliver_now
  end

  # suggests people for current_user to friend
  def strangers_to_friend
    User.all - (mutual_friends + sent_requests)
  end
end
