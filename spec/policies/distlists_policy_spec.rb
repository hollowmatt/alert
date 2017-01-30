require 'spec_helper'

RSpec.describe DistlistPolicy do 
  let(:user) { FactoryGirl.create(:user) }
  let(:follower) { FactoryGirl.create(:follower) }
  let(:priority) { FactoryGirl.create(:priority) }
  let(:platform) { FactoryGirl.create(:platform) }
  let(:distlist) { FactoryGirl.create(:distlist, priority: priority, platform: platform, follower: follower) }

  subject { described_class }

  context "policy_scope" do
    subject { Pundit.policy_scope(user, Distlist) }

    it "is empty for anonymous users" do 
      expect(Pundit.policy_scope(nil, Distlist)).to be_empty
    end

    it "returns all distlists for an admin" do 
      user.admin = true
      expect(subject).to include(distlist)
    end
  end

  context "permissions" do 
    subject { DistlistPolicy.new(user, distlist) }

    context "for anonymous users" do 
      it { should_not permit_action :index }
      it { should_not permit_action :new }
      it { should_not permit_action :create }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for admin users" do 
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :index }
      it { should permit_action :new }
      it { should permit_action :create }
      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end
  end
 end
