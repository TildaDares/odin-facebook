class Friendship < ApplicationRecord
  belongs_to :user # friend request sender
  belongs_to :friend, class_name: 'User' # friend request receiver
end
