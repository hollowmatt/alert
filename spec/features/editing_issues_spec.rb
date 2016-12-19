require "spec_helper"

feature "users can edit existing issues" do 
  let(:platform) {FactoryGirl.create(:platform)}
  let(:issue) {FactoryGirl.create(:issue, platform: platform)}

  before do 
    visit platform_issue_path(platform, issue)
    click_link "Edit Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Subject" with "This is the subject"
    click_button "Update Issue"

    expect(page).to have_content "Issue has been updated."

    within("#issue h2") do 
      expect(page).to have_content "This is he subject"
    end
  end

  scenario "without valid attributes" do 
    fill_in "Subject" with ""
    click_link "Update Issue"

    expect(page).to have_content "Issue has not been updated."
  end
end

