require 'spec_helper'

feature "Users can view platforms" do 
  scenario "with the platform details" do 
    platform = FactoryGirl.create(:platform, name: "NOOK Dot Com")
    visit "/"
    click_link "NOOK Dot Com"
    expect(page.current_url).to eq platform_url(platform)
  end
end