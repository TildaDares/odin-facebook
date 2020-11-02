class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create]
  validates :username, presence: true, length: {minimum:1}
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
      avatar.variant(resize: "150x150!").processed
    else
      'default.jpg'
    end
  end

  private
   def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default.jpg'
          )
        ), filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
   end
end
