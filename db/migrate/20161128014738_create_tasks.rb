class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status
      t.integer :creator_id, index: true
      t.integer :owner_id, index: true

      t.timestamps
    end
    add_foreign_key :tasks, :users, column: :creator_id
    add_foreign_key :tasks, :users, column: :owner_id
  end
end
