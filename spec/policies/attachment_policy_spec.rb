require 'spec_helper'

RSpec.describe AttachmentPolicy do
  context "permissions" do 
    subject{ AttachmentPolicy.new(user, attachment) }

    let(:user) { FactoryGirl.create(:user) }
    let(:platform) { FactoryGirl.create(:platform) }
    let(:status) { FactoryGirl.create(:status) }
    let(:priority) { FactoryGirl.create(:priority) }
    let(:issue) { FactoryGirl.create(:issue, platform: platform, status: status, priority: priority) }
    let(:attachment) { FactoryGirl.create(:attachment, issue: issue, 
      file_to_attach: "spec/fixtures/speed.txt") }
    
    context "for anonymous users" do 
      let(:user) { nil }
      it { should_not permit_action :show }
    end

    context "for viewers of the platform" do 
      before { assign_role!(user, :viewer, platform) }
      it { should permit_action :show }
    end

    context "for editors of the platform" do 
      before { assign_role!(user, :editor, platform) }
      it { should permit_action :show }
    end

    context "for managers of the platform" do 
      before { assign_role!(user, :manager, platform) }
      it { should permit_action :show }
    end

    context "for managers of another platform" do 
      before { assign_role!(user, :editor, FactoryGirl.create(:platform)) }
      it { should_not permit_action :show }
    end
     
    context "for admins" do 
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :show }
    end
     
  end

end
