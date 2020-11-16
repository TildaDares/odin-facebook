require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'when user logged in' do
    before(:each) do
      @user = create(:user)
      login_as(@user, scope: :user)
    end
    context 'GET index' do
      it 'assigns @users' do
        get users_path
        expect(assigns(:users)).to eq(User.all)
      end

      it 'renders the index template' do
        get users_path
        expect(response).to render_template('index')
      end
    end

    context 'GET show' do
      it 'assigns @user' do
        get user_path(@user)
        expect(assigns(:user)).to eq(@user)
      end

      it 'renders the show template' do
        get user_path(@user)
        expect(response).to render_template('show')
      end
    end

    context 'GET edit' do
      it 'assigns @user' do
        get edit_user_path(@user)
        expect(assigns(:user)).to eq(@user)
      end

      it 'renders the edit template' do
        get edit_user_path(@user)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'when user logged out' do
    context 'GET index' do
      it 'redirects back to sign-in page' do
        get '/'
        expect(response).to redirect_to :new_user_session
      end
    end
    
  end
end
