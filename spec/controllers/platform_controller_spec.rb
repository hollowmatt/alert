require 'spec_helper'

describe PlatformsController do
  it "handles a missing platform correctly" do 
    get :show, id: 'not-here'
    expect(response).to redirect_to(platforms_path)
    message = "The platform you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
