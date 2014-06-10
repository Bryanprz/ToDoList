class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :task
      t.string :description
      t.boolean :complete
      t.date :due

      t.timestamps
    end
  end
end
