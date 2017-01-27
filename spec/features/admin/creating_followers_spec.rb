require "spec_helper"

feature "Admins can create followers" do 
  scenario "with valid attributes" do 
    visit admin_followers_path
    click_link "New Follower"

    fill_in "Name", with: 'Joe Blow'
    fill_in "Email", with: 'joe@blow.com'
    click_button "Create Follower"

    expect(page).to have_content "Follower has been created."
  end
end