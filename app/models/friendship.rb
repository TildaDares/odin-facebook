class Friendship < ApplicationRecord
  belongs_to :user # request receiver
  belongs_to :friend, class_name: 'User' # request sender
end
