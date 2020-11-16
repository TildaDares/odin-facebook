require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validation tests' do
    it 'validates message presence' do
      should validate_presence_of(:message)
    end

    it 'validates url presence' do
      should validate_presence_of(:url)
    end

    it 'validates sender_id presence' do
      should validate_presence_of(:sender_id)
    end
  end

  it 'tests user association' do
    should belong_to(:user)
  end
end
