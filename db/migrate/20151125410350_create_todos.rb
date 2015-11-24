class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :is_completed, default: false
      t.belongs_to :todo_list, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
