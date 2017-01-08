class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :name
    end

    add_reference :issues, :priority, index: true, foreign_key: true
  end
end
