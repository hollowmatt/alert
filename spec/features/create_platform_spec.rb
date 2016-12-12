require 'spec_helper'

feature "Users can create new platforms" do 
  scenario "with valid attributes" do 
    visit "/"
    click_link "New Platform"
    fill_in "Name", with: "NOOK Dot Com"
    fill_in "Description", with: "Ecommerce platform"
    click_button "Create Platform"

    expect(page).to have_content "Platform created"
  end
end
