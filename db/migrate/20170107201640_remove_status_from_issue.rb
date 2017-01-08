class RemoveStatusFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :status, :text
  end
end
