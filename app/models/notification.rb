class Notification < ApplicationRecord
  belongs_to :user
  validates :message, :url, :user, :sender_id, presence: true
end
