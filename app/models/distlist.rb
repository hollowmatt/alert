class Distlist < ActiveRecord::Base
  belongs_to :priority
  belongs_to :platform
  belongs_to :follower

  # validates :email, presence: true
  # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def to_s
  	email
  end

  def email
  	Follower.find_by_id(follower_id).email
  end

end
