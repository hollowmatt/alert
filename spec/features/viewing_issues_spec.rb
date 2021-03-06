require 'spec_helper'

feature "Users can view issues" do 
  let(:status) { FactoryGirl.create(:status) }
  let(:priority) { FactoryGirl.create(:priority) }
  before do
    author = FactoryGirl.create(:user)
    caliber = FactoryGirl.create(:platform, name: 'Caliber')
    FactoryGirl.create(:issue, platform: caliber, priority: priority, author: author, subject: 'Caliber is down', issue: 'Caliber is dahn', impact: 'this is bad', status: status)
    sap = FactoryGirl.create(:platform, name: 'SAP')
    FactoryGirl.create(:issue, platform: sap, priority: priority, author: author, subject: 'SAP is slow', issue: 'peeps cannnot see reports', impact: 'this is not terrible', status: status)
    assign_role!(author, :viewer, caliber)
    login_as(author)
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