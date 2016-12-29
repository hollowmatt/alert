require 'spec_helper'

feature "Users can receive emails about an issue" do 
	let(:alice) { FactoryGirl.create(:user, email: 'alice@gmail.com') }
	let(:bob) { FactoryGirl.create(:user, email: 'bob@gmail.com') }
	let(:platform) { FactoryGirl.create(:platform, name: "NOOK Press") }
	let(:issue) do 
		FactoryGirl.create(:issue, platform: platform, author: alice, subject: "Unable to login", priority: 'P1', status: 'New')
	end

	before do 
		assign_role!(alice, :manager, platform)
		assign_role!(bob, :editor, platform)

		login_as(bob)
		visit platform_issue_path(platform, issue)
	end

	# scenario "issue creators get an email notification" do 
	# 	click_link "Email Issue"

	# 	email = find_email!(alice.email)
	# 	expected_subject = "SERVICE ALERT: New | P1 | NOOK Press: Unable to login"
	# 	expect(email.subject).to eq expected_subject

	# 	click_first_link_in_email(email)
	# 	expect(current_path).to eq platform_issue_path(platform, issue)
	# end

end
