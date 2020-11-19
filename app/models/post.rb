class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_favoritable
  has_rich_text :body
  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
  validates :body, presence: true
  validate :content_embeds
  def content_embeds
    errors.add(:base, 'Only a maximum of four photos can be posted') if rich_text_body.body.attachments.size > 4
  end
end
