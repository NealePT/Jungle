require 'rails_helper'

RSpec.feature "Visitor navigates to product page from home page", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! name: "Neale Taylor", email: "neale@neale.com", password: "neale", password_confirmation: "neale"
  end

  scenario "User can login and is taken to home page" do
    visit "/login"
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_on "Submit"

    # Uncomment to debug 
    save_and_open_screenshot

    expect(page).to have_content "Logout"
  end
end
