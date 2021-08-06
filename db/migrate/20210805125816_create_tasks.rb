class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :priority
      t.datetime :deadline
      t.boolean :completed
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
