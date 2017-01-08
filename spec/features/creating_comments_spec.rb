require 'spec_helper'

feature "users can comment on issues" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:platform) { FactoryGirl.create(:platform) }
	let(:status) { FactoryGirl.create(:status, name: 'New') }
	let(:priority)  { FactoryGirl.create(:priority) }
	let(:issue) { FactoryGirl.create(:issue, platform: platform, author: user, status: status, priority: priority) }

	before do 
		login_as(user)
		assign_role!(user, :manager, platform)
	end

	scenario "with valid attributes" do 
		visit platform_issue_path(platform, issue)
		fill_in "Text", with: "Added a comment"
		click_button "Create Comment"

		expect(page).to have_content "Comment has been created"

		within("#comments") do 
			expect(page).to have_content "Added a comment"
		end
	end

	scenario "with invalid attributes" do 
		visit platform_issue_path(platform, issue)
		click_button "Create Comment"

		expect(page).to have_content "Comment has not been created"
	end
end
