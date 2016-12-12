require 'spec_helper'

feature "Users can create new platforms" do 
  scenario "with valid attributes" do 
    visit "/"
    click_link "New Platform"
    fill_in "Name", with: "NOOK Dot Com"
    fill_in "Description", with: "Ecommerce platform"
    click_button "Create Platform"

    expect(page).to have_content "Platform created"
    
    platform = Platform.find_by(name: "NOOK Dot Com")
    expect(page.current_url).to eq platform_url(platform)
    title = "NOOK Dot Com - Platforms - Alert!"
    expect(page).to have_title title
    
  end
end
