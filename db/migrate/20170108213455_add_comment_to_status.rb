class AddCommentToStatus < ActiveRecord::Migration
  add_reference :comments, :status, foreign_key: true
end
