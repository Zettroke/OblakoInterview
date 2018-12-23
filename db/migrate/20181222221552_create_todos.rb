class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.belongs_to :project, index: true
      t.text :text
      t.boolean :isCompleted

      t.timestamps
    end
  end
end
