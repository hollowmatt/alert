class Issue < ActiveRecord::Base
  belongs_to :platform
  belongs_to :author, class_name: 'User'

  validates :priority, presence: true
  validates :subject, presence: true, length: { maximum: 140 }
  validates :issue, presence: true
  validates :impact, presence: true
  validates :status, presence: true
  mount_uploader :attachment, AttachmentUploader
end
