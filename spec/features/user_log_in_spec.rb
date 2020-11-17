require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = User.create! first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password20', password_confirmation: 'password20'
  end

  scenario "A user logs in and is redirected to the home page logged in" do
    # ACT
    visit '/login'
    # DEBUG / VERIFY
    sleep(1)
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'password20'
    click_button 'Sign In'
    sleep(1)
    expect(page).to have_text 'Signed in as Etienne LC'
    save_screenshot('user_log_in.png')
  end
end