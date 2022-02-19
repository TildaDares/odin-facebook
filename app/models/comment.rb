class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  has_rich_text :comment
  acts_as_favoritable
  validates :comment, :user, :post, presence: true
  validate :content_embeds
  def content_embeds
    errors.add(:base, 'has to be one photo') if rich_text_comment.body.attachments.size > 1
  end
end
