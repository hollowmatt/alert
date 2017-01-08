require 'spec_helper'

feature "users should be able to delete a Issue" do 
  let(:author) {FactoryGirl.create(:user) }
  let(:platform) {FactoryGirl.create(:platform) }
  let(:status) { FactoryGirl.create(:status) }
  let(:issue) {FactoryGirl.create(:issue, platform: platform, author: author, status: status) }

  before do 
    login_as(author)
    assign_role!(author, :manager, platform)
    visit platform_issue_path(platform, issue)
  end

  scenario "successful delete" do 
    click_link "Delete Issue"

    expect(page).to have_content "Issue has been deleted."
    expect(page.current_url).to eq platform_url(platform)
  end
end