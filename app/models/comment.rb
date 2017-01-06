class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: "User"
  delegate :platform, to: :issue
  scope :persisted, lambda { where.not(id:nil) }

  validates :text, presence: true
end
