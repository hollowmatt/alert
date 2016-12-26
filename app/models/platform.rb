class Platform < ActiveRecord::Base
	has_many :issues, dependent: :delete_all
  has_many :roles, dependent: :delete_all
  validates :name, presence: true
end
