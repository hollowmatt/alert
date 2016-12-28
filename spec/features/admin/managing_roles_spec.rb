require 'spec_helper'

feature "Admins can manager a user's roles" do 
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:caliber) { FactoryGirl.create(:platform, name: "Caliber") }
  let!(:mercury) { FactoryGirl.create(:platform, name: "Mercury DB") }

  before do 
    login_as(admin)
  end

  scenario "When assigning roles to an existing user" do 
    visit admin_user_path(user)
    click_link "Edit User"

    select "Viewer", from: "Caliber"
    select "Manager", from: "Mercury DB"

    click_button "Update User"
    expect(page).to have_content "User has been updated"

    click_link user.email
    expect(page).to have_content "Caliber: Viewer"
    expect(page).to have_content "Mercury DB: Manager"
  end

  scenario "when assigning roles to a new user" do 
    visit new_admin_user_path

    fill_in "Email", with: "newuser@gmail.com"
    fill_in "Password", with: "password"

    select "Editor", from: "Caliber"
    click_button "Create User"

    click_link "newuser@gmail.com"
    expect(page).to have_content "Caliber: Editor"
    expect(page).not_to have_content "Mercury DB"
  end

end
