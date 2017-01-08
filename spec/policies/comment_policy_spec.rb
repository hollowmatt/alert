require 'spec_helper'

RSpec.describe CommentPolicy do

  context "permissions" do 
    subject{ CommentPolicy.new(user, comment) }

    let(:user) { FactoryGirl.create(:user) }
    let(:platform) { FactoryGirl.create(:platform) }
    let(:status) { FactoryGirl.create(:status) }
    let(:priority) { FactoryGirl.create(:priority) }
    let(:issue) { FactoryGirl.create(:issue, platform: platform, status: status, priority: priority) }
    let(:comment) { FactoryGirl.create(:comment, issue: issue) }
    
    context "for anonymous users" do 
      let(:user) { nil }
      it { should_not permit_action :create }
    end

    context "for viewers of the platform" do 
      before { assign_role!(user, :viewer, platform) }
      it { should_not permit_action :create }
    end

    context "for editors of the platform" do 
      before { assign_role!(user, :editor, platform) }
      it { should permit_action :create }
    end

    context "for managers of the platform" do 
      before { assign_role!(user, :manager, platform) }
      it { should permit_action :create }
    end

    context "for managers of another platform" do 
      before { assign_role!(user, :editor, FactoryGirl.create(:platform)) }
      it { should_not permit_action :create }
    end
     
    context "for admins" do 
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :create }
    end
     
  end
end
