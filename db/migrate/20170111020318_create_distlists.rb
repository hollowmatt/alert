class CreateDistlists < ActiveRecord::Migration
  def change
    create_table :distlists do |t|
      t.string :email
      t.references :priority, index: true, foreign_key: true
      t.references :platform, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
