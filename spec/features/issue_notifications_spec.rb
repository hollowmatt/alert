require 'spec_helper'

feature "users can receive notifications about ticket updates" do 
  let(:alice) { FactoryGirl.create(:user, email: 'alice@example.com') }
  let(:bob) { FactoryGirl.create(:user, email: 'bob@example.com') }
  let(:platform) { FactoryGirl.create(:platform) }
  let(:status) { FactoryGirl.create(:status) }
  let(:priority) { FactoryGirl.create(:priority) }
  let(:follower) { FactoryGirl.create(:follower) }
  let(:distlist) { FactoryGirl.create(:distlist, priority: priority, platform: platform, follower: follower) }
  
  let(:issue) do 
    FactoryGirl.create(:issue, 
      platform: platform, 
      priority: priority, 
      author: alice, 
      status: status)
  end

  before do 
    assign_role!(alice, :manager, platform)
    assign_role!(bob, :manager, platform)

    login_as(bob)
    visit platform_issue_path(platform, issue)
    puts distlist
  end

  scenario "ticket author automatically receives notification" do 
    fill_in "Text", with: "Added a comment"
    click_button "Create Comment"

    email = find_email!(follower.email)
    expected_subject = "SERVICE ALERT: #{status} | #{priority} | #{platform.name}: #{issue.subject}"
    expect(email.subject).to eq expected_subject

    click_first_link_in_email(email)
    expect(current_path).to eq platform_issue_path(platform, issue)
  end
end