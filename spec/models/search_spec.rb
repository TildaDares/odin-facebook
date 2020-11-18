require 'rails_helper'

RSpec.describe Search, type: :model do
  it 'validates presence of words' do
    should validate_presence_of(:words)
  end

  it 'validates uniqueness of words' do
    should validate_uniqueness_of(:words).case_insensitive
  end

  it 'tests user association' do
    should belong_to(:user)
  end
end
