class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.text :description
      t.string :category
      t.text :review
      t.integer :maturity, default: 0
      t.date :completion_date

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
