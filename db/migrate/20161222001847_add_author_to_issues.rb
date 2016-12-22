class AddAuthorToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :author, index: true
    add_foreign_key :issues, :users, column: :author_id
  end
end
