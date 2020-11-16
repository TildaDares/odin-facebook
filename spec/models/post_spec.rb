require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'association test' do
    it 'tests the comments association' do
      should have_many(:comments)
    end

    it 'tests the actiontext association' do
      should have_one(:action_text_rich_text).class_name('ActionText::RichText')
    end
  end  
end
