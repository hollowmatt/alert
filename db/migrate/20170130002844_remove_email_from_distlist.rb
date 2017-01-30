class RemoveEmailFromDistlist < ActiveRecord::Migration
  def change
    remove_column :distlists, :email, :string
  end
end
