require "spec_helper"

feature "Users can edit existing projects" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:platform) { FactoryGirl.create(:platform, name: "NOOK Dot Com") }

  before do 
    assign_role!(user, :manager, platform)
    login_as(user)
    
    visit "/"
    click_link "NOOK Dot Com"
    click_link "Edit Platform"
  end


  scenario "with valid attributes" do 
    fill_in "Name", with: "NOOK UK"
    click_button "Update Platform"
    
    expect(page).to have_content "Platform has been updated."
    expect(page).to have_content "NOOK UK"
  end

  scenario "with invalid attributes" do 
    fill_in "Name", with: ""
    click_button "Update Platform"

    expect(page).to have_content "Platform has not been updated."  
  end

end