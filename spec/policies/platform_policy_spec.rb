require 'spec_helper'

RSpec.describe PlatformPolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:platform) { FactoryGirl.create(:platform) }

  subject { described_class }

  context "policy_scope" do 
    subject { Pundit.policy_scope(user, Platform) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let(:user) { FactoryGirl.create(:user) }

    it "is empty for anonymous users" do 
      expect(Pundit.policy_scope(nil, Platform)).to be_empty
    end

    it "includes platforms a user is allowed to see" do 
      assign_role!(user, :viewer, platform)
      expect(subject).to include(platform)
    end

    it "doesn't include platforms a user isn't allowed to see" do 
      expect(subject).to be_empty
    end

    it "returns all platforms for an admin" do 
      user.admin = true
      expect(subject).to include(platform)
    end
  end

  context "permissions" do 
    subject{ PlatformPolicy.new(user, platform) }

    let(:user) { FactoryGirl.create(:user) }
    let(:platform) { FactoryGirl.create(:platform) }

    context "for anonymous users" do 
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for viewers of the platform" do 
      before { assign_role!(user, :viewer, platform) }
      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for editors of the platform" do 
      before { assign_role!(user, :editor, platform) }
      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for managers of the platform" do 
      before { assign_role!(user, :manager, platform) }
      it { should permit_action :show }
      it { should permit_action :update }
    end

    context "for managers of another platform" do 
      before { assign_role!(user, :editor, FactoryGirl.create(:platform)) }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end
     
    context "for admins" do 
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :show }
      it { should permit_action :update }
    end
     
  end

end
