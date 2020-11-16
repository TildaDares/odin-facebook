require 'rails_helper'

RSpec.feature 'Sign In', type: :feature do
  it 'signs the user in' do
    visit '/users/sign_in'
    user = create(:user)
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_current_path(root_path)
  end
end
