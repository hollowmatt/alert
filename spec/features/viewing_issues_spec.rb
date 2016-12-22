require 'spec_helper'

feature "Users can view issues" do 
  before do
    author = FactoryGirl.create(:user)
    caliber = FactoryGirl.create(:platform, name: 'Caliber')
    FactoryGirl.create(:issue, platform: caliber, priority:'P1', author: author, subject: 'Caliber is down', issue: 'Caliber is dahn', impact: 'this is bad', status:'new')

    sap = FactoryGirl.create(:platform, name: 'SAP')
    FactoryGirl.create(:issue, platform: sap, priority:'P3', author: author, subject: 'SAP is slow', issue: 'peeps cannnot see reports', impact: 'this is not terrible', status:'in process')

    visit "/"
  end

  scenario 'for a given platform' do
    click_link 'Caliber'

    expect(page).to have_content "Caliber is down"
    expect(page).to_not have_content "SAP is slow"

    click_link "Caliber is down"
    within("#issue h2") do
      expect(page).to have_content "Caliber is down"
    end

    expect(page).to have_content "Caliber is dahn"
  end
end