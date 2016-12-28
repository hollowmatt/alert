require 'spec_helper'

RSpec.describe IssuePolicy do
  

  context "permissions" do 
    subject{ IssuePolicy.new(user, issue) }

    let(:user) { FactoryGirl.create(:user) }
    let(:platform) { FactoryGirl.create(:platform) }
    let(:issue) { FactoryGirl.create(:issue, platform: platform) }
    
    context "for anonymous users" do 
      let(:user) { nil }
      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context "for viewers of the platform" do 
      before { assign_role!(user, :viewer, platform) }
      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context "for editors of the platform" do 
      before { assign_role!(user, :editor, platform) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
    end

    context "for managers of the platform" do 
      before { assign_role!(user, :manager, platform) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
    end

    context "for managers of another platform" do 
      before { assign_role!(user, :editor, FactoryGirl.create(:platform)) }
      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end
     
    context "for admins" do 
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
    end
     
  end
  
end
