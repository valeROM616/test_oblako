class AddValidationToTodosAndProjects < ActiveRecord::Migration[5.2]
  def change
    change_column :todos, :isCompleted, :boolean, default: false
    change_column :todos, :text, :string, null: false
    change_column :projects, :title, :string, null: false
  end
end
