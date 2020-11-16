require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @post = Post.create!(body: 'I am a foodie', user: create(:user))
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get posts_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    it 'assigns @post' do
      get post_path(@post)
      expect(assigns(:post)).to eq(@post)
    end

    it 'renders the show template' do
      get post_path(@post)
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    it 'creates a new post and redirects to the show page' do
      get new_post_path
      expect(response).to render_template('new')

      post '/posts', params: { post: { body: 'I love dogs', user: @user } }
      expect(response).to redirect_to(assigns(:post))
      follow_redirect!

      expect(response).to render_template('show')
    end
  end
end
