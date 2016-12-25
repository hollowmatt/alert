require 'spec_helper'

feature "Admins can create users" do 
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do 
    login_as(admin)
    visit "/"
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "with valid credentials" do 
    fill_in "Email", with: "newbie@gmail.com"
    fill_in "Password", with: "password"
    click_button "Create User"
    expect(page).to have_content "User has been created."
  end

  scenario "with invalid attributes" do
    fill_in "Email", with: ''
    fill_in "Password", with: ''
    click_button "Create User"
    expect(page).not_to have_content "User has been created."
    expect(page).to have_content "User has not been created."
  end

  scenario "setting a user to admin" do
    fill_in "Email", with: "admin@gmail.com"
    fill_in "Password", with: "password"
    check "Is an Admin?"
    click_button "Create User"
    expect(page).to have_content "User has been created."
    expect(page).to have_content "admin@gmail.com (Admin)"
  end


end
