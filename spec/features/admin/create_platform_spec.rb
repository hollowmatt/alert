require 'spec_helper'

feature "Users can create new platforms" do 

  before do 
    visit "/"
    login_as(FactoryGirl.create(:user, :admin))
    click_link "New Platform"
  end

  scenario "with valid attributes" do 
    fill_in "Name", with: "NOOK Dot Com"
    fill_in "Description", with: "Ecommerce platform"
    click_button "Create Platform"

    expect(page).to have_content "Platform created"
    
    platform = Platform.find_by(name: "NOOK Dot Com")
    expect(page.current_url).to eq platform_url(platform)
    title = "NOOK Dot Com - Platforms - Alert!"
    expect(page).to have_title title
  end

  scenario "with invalid attributes" do 
    click_button "Create Platform"

    expect(page).to have_content "Platform has not been created."
    expect(page).to have_content "Name can't be blank"
  end

end
