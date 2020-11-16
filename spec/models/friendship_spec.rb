require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'tests user association' do
    should belong_to(:user)
  end

  it 'tests friend association' do
    should belong_to(:friend).class_name('User')
  end
end
