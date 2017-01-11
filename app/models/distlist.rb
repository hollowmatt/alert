class Distlist < ActiveRecord::Base
  belongs_to :priority
  belongs_to :platform

  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def to_s
  	email
  end

end
