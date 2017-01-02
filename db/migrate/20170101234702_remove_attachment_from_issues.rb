class RemoveAttachmentFromIssues < ActiveRecord::Migration
  def change
    remove_column :issues, :attachment, :string
  end
end
