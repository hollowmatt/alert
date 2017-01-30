class AddFollowerToDistlist < ActiveRecord::Migration
  add_reference :distlists, :follower, index: true, foreign_key: true
end
