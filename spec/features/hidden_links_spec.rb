require 'spec_helper'

feature "Users can only see the appropriate links/buttons" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:platform) { FactoryGirl.create(:platform) }
  
  context "anonymous users" do 
    scenario "Cannot see the new platform button" do
      visit "/"
      expect(page).not_to have_link "New Platform"
    end
    scenario "Cannot see the delete platform button" do 
      visit platform_path(platform)
      expect(page).not_to have_link "Delete Platform" 
    end
    scenario "Cannot see the edit platform button" do 
      visit platform_path(platform)
      expect(page).not_to have_link "Edit Platform" 
    end
  end

  context "normal users" do 
    before do 
      login_as(user)
    end

    scenario "Cannot see new Platform button" do 
      visit "/"
      expect(page).not_to have_link "New Platform"
    end
    scenario "Cannot see the delete platform button" do 
      visit platform_path(platform)
      expect(page).not_to have_link "Delete Platform" 
    end
    scenario "Cannot see the edit platform button" do 
      visit platform_path(platform)
      expect(page).not_to have_link "Edit Platform" 
    end
  end

  context "admin users" do 
    before do 
      login_as(admin)
    end

    scenario "Should see the new Platform button" do 
      visit "/"
      expect(page).to have_link "New Platform"
    end
    scenario "Should see the delete platform button" do 
      visit platform_path(platform)
      expect(page).to have_link "Delete Platform" 
    end
    scenario "Should see the edit platform button" do 
      visit platform_path(platform)
      expect(page).to have_link "Edit Platform" 
    end
  end
end