require 'spec_helper'

feature "Users can create new issues" do 
	
	let(:user) { FactoryGirl.create(:user) }

	before do 
		login_as(user)
		platform = FactoryGirl.create(:platform, name: "Caliber")
		visit platform_path(platform)
		click_link "New Issue"
	end

	scenario "With valid attributes" do 
		select "P1", from: "Priority"
		fill_in "Subject", with: "Caliber account service is down"
		fill_in "Issue", with: "Users are unable to log in with devices, apps or NOOK Digital sites (nook.com, nook press)"
		fill_in "Impact", with: "This is impacting a larger number of users"
		fill_in "Ticket", with: "SYS-1234"
		fill_in "Status", with: "Operations and engineering notified, a bridge will be opened.  Details to follow."
		fill_in "Next steps", with: "Bridge call to be opened"
		click_button "Create Issue"

		expect(page).to have_content "Issue has been created."

		within ("#issue") do
			expect(page).to have_content "Creator: #{user.email}"
		end
	end

	scenario "With invalid attributes" do 
		click_button "Create Issue"
		expect(page).to have_content "Issue has not been created."
		expect(page).to have_content "Subject can't be blank"
		expect(page).to have_content "Issue can't be blank"
		expect(page).to have_content "Impact can't be blank"
		expect(page).to have_content "Status can't be blank"
	end

	scenario "with an invalid subject" do 
		select "P1", from: "Priority"
		fill_in "Subject", with: "Caliber account service is down and there are people running around with their hair on fire, and cats and dogs are living together and the world is in chaos, what have we done????"
		fill_in "Issue", with: "Users are unable to log in with devices, apps or NOOK Digital sites (nook.com, nook press)"
		fill_in "Impact", with: "This is impacting a larger number of users"
		fill_in "Ticket", with: "SYS-1234"
		fill_in "Status", with: "Operations and engineering notified, a bridge will be opened.  Details to follow."
		fill_in "Next steps", with: "Bridge call to be opened"
		click_button "Create Issue"
		expect(page).to have_content "Issue has not been created."
		expect(page).to have_content "Subject is too long"
	end
end