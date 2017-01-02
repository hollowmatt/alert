class Issue < ActiveRecord::Base
  belongs_to :platform
  belongs_to :author, class_name: 'User'
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :priority, presence: true
  validates :subject, presence: true, length: { maximum: 140 }
  validates :issue, presence: true
  validates :impact, presence: true
  validates :status, presence: true
  
end
