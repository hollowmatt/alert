require 'spec_helper'

RSpec.describe PlatformPolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:platform) { FactoryGirl.create(:platform) }

  subject { described_class }

  permissions :show? do
    it "blocks anonymous users" do 
      expect(subject).not_to permit(nil, platform)
    end

    it "allows viewers of the project" do 
      assign_role!(user, :viewer, platform)
      expect(subject).to permit(user, platform)
    end

    it "allows editors of the project" do 
      assign_role!(user, :editor, platform)
      expect(subject).to permit(user, platform)

    end

    it "allows managers of the project" do 
      assign_role!(user, :manager, platform)
      expect(subject).to permit(user, platform)
    end

    it "allows admins" do 
      admin = FactoryGirl.create(:user, :admin)
      expect(subject).to permit(admin, platform)
    end

    it "doesn't allow users of other projects" do 
      other_platform = FactoryGirl.create(:platform, name: 'Other')
      assign_role!(user, :viewer, other_platform)
      expect(subject).not_to permit(user, platform)
    end

  end
end
