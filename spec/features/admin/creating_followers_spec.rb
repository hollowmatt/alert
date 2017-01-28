require "spec_helper"

feature "Admins can create followers" do 

	let(:admin) { FactoryGirl.create(:user, :admin) }

  before do 
    login_as(admin)
    visit admin_followers_path
    click_link "New Follower"
  end

  scenario "with valid attributes" do 
    fill_in "Name", with: 'Joe Blow'
    fill_in "Email", with: 'joe@blow.com'
    click_button "Create Follower"

    expect(page).to have_content "Follower has been created."
  end
end