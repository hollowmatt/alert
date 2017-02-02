require "spec_helper"

feature "Admins can create distlists" do
	let(:admin) { FactoryGirl.create(:user, :admin) }

	before do
		login_as(admin)
		FactoryGirl.create(:priority, name: 'P1')
		FactoryGirl.create(:platform, name: 'NOOK') 
		FactoryGirl.create(:follower) 

		visit admin_distlists_path
		click_link "Add to list"
	end

	it "has valid attributes" do 
		select "NOOK", from: "Platform"
		select "P1", from: "Priority"
		select "Joe Blow", from: "Follower"
		click_button "Add to Distlist"

		expect(page).to have_content "Joe Blow has been added to distlist"
	end
end