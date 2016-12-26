require 'spec_helper'

feature "admin can archive users" do 
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do 
    login_as(admin)
  end

  scenario "successfully archive user" do 
    visit admin_user_path(user)
    click_link "Archive User"

    expect(page).to have_content "User has been archived."
    expect(page).not_to have_content user.email
  end

  scenario "cannot archive self" do 
    visit admin_user_path(admin)
    click_link "Archive User"

    expect(page).not_to have_content "User has been archived."
    expect(page).to have_content "You cannot archive yourself."
    expect(page).to have_content admin.email
  end

end