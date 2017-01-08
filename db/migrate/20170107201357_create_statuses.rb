class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :color
		end

		add_reference :issues, :status, index: true, foreign_key: true
  end
end
