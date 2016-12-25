require 'spec_helper'

feature "Users can delete platforms" do 
  before do 
    login_as(FactoryGirl.create(:user, :admin))
  end
  
  scenario "successful delete" do 
    FactoryGirl.create(:platform, name: "NOOK Dot Com")

    visit "/"
    click_link "NOOK Dot Com"
    click_link "Delete Platform"

    expect(page).to have_content "Platform has been deleted."
    expect(page.current_url).to eq platforms_url
    expect(page).to have_no_content "NOOK Dot Com"
  end
end
