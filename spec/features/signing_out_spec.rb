require 'spec_helper'

feature 'signing users out' do 
  let!(:user) { FactoryGirl.create(:user)}

  before do 
    login_as(user)
  end

  scenario 'logout' do 
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
