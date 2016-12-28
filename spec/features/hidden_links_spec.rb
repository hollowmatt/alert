require 'spec_helper'

feature "Users can only see the appropriate links/buttons" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:platform) { FactoryGirl.create(:platform) }
  let(:issue) { FactoryGirl.create(:issue, platform: platform, author: user) }
  
  context "anonymous users" do 
    scenario "Cannot see the new platform button" do
      visit "/"
      expect(page).not_to have_link "New Platform"
    end
  end

  context "viewer users" do 
    before do 
      login_as(user)
      assign_role!(user, :viewer, platform)
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

    scenario "Cannot see the new issue link" do 
      visit platform_path(platform)
      expect(page).not_to have_link "New Issue"
    end

    scenario "Cannot see the edit issue link" do 
      visit platform_issue_path(platform, issue)
      expect(page).not_to have_link "Edit Issue"
    end

  end

  context "manager users" do 
    before do 
      login_as(user)
      assign_role!(user, :manager, platform)
    end

    scenario "Cannot see new Platform button" do 
      visit "/"
      expect(page).not_to have_link "New Platform"
    end

    scenario "Cannot see the delete platform button" do 
      visit platform_path(platform)
      expect(page).not_to have_link "Delete Platform" 
    end

    scenario "Can see the edit platform button" do 
      visit platform_path(platform)
      expect(page).to have_link "Edit Platform" 
    end

    scenario "Can see the new issue link" do 
      visit platform_path(platform)
      expect(page).to have_link "New Issue"
    end

    scenario "Can see the edit issue link" do 
      visit platform_issue_path(platform, issue)
      expect(page).to have_link "Edit Issue"
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
    
    scenario "Can see the new issue link" do 
      visit platform_path(platform)
      expect(page).to have_link "New Issue"
    end

    scenario "Can see the edit issue link" do 
      visit platform_issue_path(platform, issue)
      expect(page).to have_link "Edit Issue"
    end
  end
end