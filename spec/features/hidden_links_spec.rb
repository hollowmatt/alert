require 'spec_helper'

feature "Users can only see the appropriate links/buttons" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  context "anonymous users" do 
    scenario "Cannot see the new platform button" do
      visit "/"
      expect(page).not_to have_link "New Platform"
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
  end

  context "admin users" do 
    before do 
      login_as(admin)
    end

    scenario "Should see the new Platform button" do 
      visit "/"
      expect(page).to have_link "New Platform"
    end
  end
end