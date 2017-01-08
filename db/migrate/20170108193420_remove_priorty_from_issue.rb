class RemovePriortyFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :priority, :string
  end
end
