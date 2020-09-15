class ProjectController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    projects = Project.all
    render json: projects.as_json(include: :todos)
  end

  def create_todo
    proj = Project.where(title: todo_params['project_title']).first_or_create do |project|
      project.title = todo_params['project_title']
    end
    todo = Todo.new(text: todo_params['text'], project_id: proj.id)
    if todo.save
      render json: todo
    else
      render json: {message: todo.errors.messages}
    end
  end

  def update
    todo = Todo.find(todo_patch['todo_id'])
    todo.isCompleted = !todo.isCompleted

    if todo.save
      render json: todo
    else
      render json: {message: todo.errors.messages}
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:text, :isCompleted, :project_id, :project_title)
  end

  def todo_patch
    params.permit(:project_id, :todo_id)
  end
end
