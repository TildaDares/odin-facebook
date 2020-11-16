class Search < ApplicationRecord
  validates :words, presence: true, uniqueness: { case_sensitive: false }
end
