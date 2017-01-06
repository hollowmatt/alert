class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: "User"

  validates :text, presence: true
end
