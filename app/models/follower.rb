class Follower < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :email, uniqueness: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	has_many :distlists, dependent: :destroy
  
end
