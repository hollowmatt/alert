class Issue < ActiveRecord::Base
  belongs_to :platform
  belongs_to :author, class_name: 'User'
  belongs_to :status
  belongs_to :priority
  
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :priority, presence: true
  validates :subject, presence: true, length: { maximum: 140 }
  validates :issue, presence: true
  validates :impact, presence: true
  validates :status, presence: true

  def watchers
    Distlist.where(:priority => priority, :platform  => platform)
  end
  
end
