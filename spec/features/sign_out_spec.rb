require 'rails_helper'

RSpec.feature "Sign Out", type: :feature do
  it 'signs the user out' do
    @user = create(:user)
    login_as(@user, scope: :user)
    visit '/account'
    click_link 'Logout'
    expect(page).to have_current_path(new_user_session_path)
  end
end
