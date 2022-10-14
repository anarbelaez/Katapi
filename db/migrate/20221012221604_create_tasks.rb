class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0
      t.integer :priority, default: 0
      t.integer :difficulty, default: 0
      t.date :due_date
      t.date :completion_date
      t.text :review

      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
