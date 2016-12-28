require 'spec_helper'

describe PlatformsController, type: :controller do
  it "handles a missing platform correctly" do 
    get :show, id: 'not-here'
    expect(response).to redirect_to(platforms_path)
    message = "The platform you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do 
    allow(controller).to receive(:current_user)
    platform = FactoryGirl.create(:platform)
    get :show, id: platform

    expect(response).to redirect_to root_path
    message = "You don't have permission to perform that action."
    expect(flash[:alert]).to eq message
  end

end
