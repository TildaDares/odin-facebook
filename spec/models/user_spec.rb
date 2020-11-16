require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation test' do
    context 'username validation test' do
      it 'validates username presence' do
        should validate_presence_of(:username)
      end

      it 'validates username length' do
        should validate_length_of(:username).is_at_least(1).is_at_most(50)
      end
    end

    context 'bio validation test' do
      it 'validates bio length' do
        should validate_length_of(:bio).is_at_most(160)
      end
    end

    context 'location validation test' do
      it 'validates location length' do
        should validate_length_of(:location).is_at_most(30)
      end
    end
  end

  describe 'association test' do
    it 'tests the post asssociation' do
      should have_many(:posts)
    end

    it 'tests the comments association' do
      should have_many(:comments)
    end

    it 'tests the notifications association' do
      should have_many(:notifications)
    end

    it 'tests the friendships association' do
      should have_many(:friendships)
    end

    it 'tests the friends association' do
      should have_many(:friends).through(:friendships)
    end

    it 'tests the inverse_friendships association' do
      should have_many(:inverse_friendships).class_name('Friendship')
    end

    it 'tests the inverse_friends association' do
      should have_many(:inverse_friends).through(:inverse_friendships).source(:user)
    end
  end

  describe 'friendship test' do
    before(:all) do
      @user = create(:user)
      @friend1 = create(:user)
      @friend2 = create(:user)
      @friend3 = create(:user)
      @friend4 = create(:user)
      @friend5 = create(:user)
      @friend1.friendships.build(friend: @user).save
      @friend2.friendships.build(friend: @user).save
      @friend3.friendships.build(friend: @user).save
      @user.friendships.build(friend: @friend3).save
      @user.friendships.build(friend: @friend4).save
    end

    it "returns the user's friend requests" do
      expect(@user.friend_requests).to eq([@friend1, @friend2])
    end

    it "returns the user's mutual friends" do
      expect(@user.mutual_friends).to eq([@friend3])
    end

    it "returns the user's sent requests" do
      expect(@user.sent_requests).to eq([@friend4])
    end

    it 'returns the users that the current_user is not connected to' do
      expect(@user.strangers).not_to include(@friend1, @friend2, @friend3, @friend4)
    end

    context 'friendship buttons' do
      it 'returns an add friend text' do
        expect(@user.friendship_status(@friend5)).to eq('Add Friend')
      end

      it 'returns an unfriend text' do
        expect(@user.friendship_status(@friend3)).to eq('Unfriend')
      end

      it 'returns an accept request text' do
        expect(@user.friendship_status(@friend1)).to eq('Accept Request')
      end

      it 'returns a cancel request text' do
        expect(@user.friendship_status(@friend4)).to eq('Cancel Request')
      end
    end
  end
end
