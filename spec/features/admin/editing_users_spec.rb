require 'spec_helper'

feature "Admins can edit users" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(admin)
    visit admin_user_path(user)
    click_link "Edit User"
  end

  scenario "with valid credentials" do 
    fill_in "Email", with: "newb@email.com"
    click_button "Update User"

    expect(page).to have_content "User has been updated."
    expect(page).to have_content "newb@email.com"
    expect(page).not_to have_content user.email
  end

  scenario "when toggling admin" do
    check "Is an Admin?"
    click_button "Update User"
    expect(page).to have_content "User has been updated."
    expect(page).to have_content "#{user.email} (Admin)"
  end
end