require "spec_helper"

feature "Users can edit existing projects" do 
  before do 
    FactoryGirl.create(:platform, name: "NOOK Dot Com")
    visit "/"
    click_link "NOOK Dot Com"
    click_link "Edit Platform"
  end

  scenario "with valid attributes" do 
    fill_in "Name", with: "NOOK UK"
    click_button "Update Platform"

    expect(page).to have_content "Platform updated"
    expect(page).to have_content "NOOK UK"
  end

  scenario "with invalid attributes" do 
    fill_in "Name", with: ""
    click_button "Update Platform"

    expect(page).to have_content "Platform has not been updated."  
  end

end
