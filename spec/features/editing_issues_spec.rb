require "spec_helper"

feature "users can edit existing issues" do 
  let(:author) {FactoryGirl.create(:user)}
  let(:platform) {FactoryGirl.create(:platform)}
  let(:issue) {FactoryGirl.create(:issue, platform: platform, author: author)}

  before do 
    assign_role!(author, :editor, platform)
    login_as(author)
    visit platform_issue_path(platform, issue)
    click_link "Edit Issue"
  end

  scenario "with valid attributes" do
    fill_in "Subject", with: "This is the subject"
    click_button "Update Issue"

    expect(page).to have_content "Issue has been updated."

    within("#issue h2") do 
      expect(page).to have_content "This is the subject"
    end
  end

  scenario "without valid attributes" do 
    fill_in "Subject", with: ""
    click_button "Update Issue"

    expect(page).to have_content "Issue has not been updated."
  end
end

