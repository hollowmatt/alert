require 'spec_helper'

describe CommentNotifier, type: :mailer do 
  describe "created" do 
    let(:platform) { FactoryGirl.create(:platform) }
    let(:issue_owner) { FactoryGirl.create(:user) }
    let(:status) { FactoryGirl.create(:status) }
    let(:priority) { FactoryGirl.create(:priority) }
    let(:distlist) { FactoryGirl.create(:distlist, priority: priority, platform: platform, email: issue_owner.email) }
    
    let(:issue) do 
      FactoryGirl.create(:issue, 
        platform: platform, 
        priority: priority, 
        author: issue_owner, 
        status: status)
    end

    let(:commenter) { FactoryGirl.create(:user) }
    let(:comment) do
      Comment.new(issue: issue, author: commenter, text: 'Test comment')
    end

    let(:email) do 
      CommentNotifier.created(comment, issue_owner)
    end

    it "sends an email about a new comment" do 
      expect(email.to).to include issue_owner.email
      expect(email.body.to_s).to include comment.text
    end
  end
end
