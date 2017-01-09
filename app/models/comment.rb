class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: "User"
  belongs_to :status
  delegate :platform, to: :issue
  scope :persisted, lambda { where.not(id:nil) }

  validates :text, presence: true

  after_create :set_issue_status

  private
  	def set_issue_status
  		if status
  			issue.status = status
  			issue.save!
  		end
  	end
end
