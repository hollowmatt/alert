class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :priority
      t.string :subject
      t.text :issue
      t.text :impact
      t.string :ticket
      t.text :status
      t.text :next_steps
      t.references :platform, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
