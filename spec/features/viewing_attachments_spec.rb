require 'spec_helper'

feature "User's can view an issues attached files" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:platform) { FactoryGirl.create(:platform) }
  let(:status) { FactoryGirl.create(:status) }
  let(:priority) { FactoryGirl.create(:priority) }
  let(:issue) { FactoryGirl.create(:issue, platform: platform, author: user, status: status, priority: priority) }
  let!(:attachment) { FactoryGirl.create(:attachment, issue: issue, 
    file_to_attach: "spec/fixtures/speed.txt") }

  before do 
    assign_role!(user, :viewer, platform)
    login_as(user)
  end

  scenario "successful view" do 
    visit platform_issue_path(platform, issue)
    click_link("speed.txt")

    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content("this is a sample")
  end
end
