class Search < ApplicationRecord
  belongs_to :user
  validates :words, presence: true, uniqueness: { case_sensitive: false }
end
