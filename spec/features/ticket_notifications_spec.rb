require 'spec_helper'

feature "Users can receive emails aobut a issue" do 
	let(:alice) { FactoryGirl.create(:user, email: 'alice@gmail.com') }
	let(:bob) { FactoryGirl.create(:user, email: 'bob@gmail.com') }
	let(:platform) { FactoryGirl.create(:platform) }
	let(:issue) do 
		FactoryGirl.create(:issue, platform: platform, author: alice)
	end

	before do 
		assign_role!(alice, :manager, platform)
		assign_role!(bob, :editor, platform)

		login_as(bob)
		visit platform_issue_path(platform, issue)
	end

	scenario "issue creators get an email notification" do 
	end

end
