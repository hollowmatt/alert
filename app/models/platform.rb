class Platform < ActiveRecord::Base
  validates :name, presence: true
end
