require 'spec_helper'

feature "Users can view platforms" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:platform) { FactoryGirl.create(:platform, name: "NOOK Dot Com") }

  before do 
    login_as(user)
    assign_role!(user, :viewer, platform)
  end

  scenario "with the platform details" do 
    visit "/"
    click_link "NOOK Dot Com"
    expect(page.current_url).to eq platform_url(platform)
  end

  scenario "unless they don't have permission" do 
    FactoryGirl.create(:platform, name: 'Hidden')
    visit "/"
    expect(page).not_to have_content("Hidden")
  end
end