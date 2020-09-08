class ChangeColumnToTodos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :todos, :projects, index: true, foreign_key: true
    add_reference :todos, :project, foreign_key: true
  end
end
