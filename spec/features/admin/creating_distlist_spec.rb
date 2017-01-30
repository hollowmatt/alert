require "spec_helper"

feature "Admins can create distlists" do
	let(:admin) { FactoryGirl.create(:user, :admin) }
	let(:priority) { FactoryGirl.create(:priority) }
	let(:platform) { FactoryGirl.create(:platform) }
	let(:follower) { FactoryGirl.create(:follower) }

	before do
		login_as(admin)
		visit admin_distlists_path
		click_link "Add Follower to Distlist"
	end

	xit "with valid attributes" do 
		select "P1", from: "Priority"
		select "NOOK Dot Com", from: "Platform"
		select "Joe Blow", from: "Follower"
		click_button "Add to dist list"

		expect(page).to have_content "#{follower.name} has been added to distlist"
	end
end