class ProjectController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @projects = Project.all
    @projects = JSON.parse(@projects.to_json(include: :todos))
    render json: @projects.to_json
  end

  def create_todo
    todo_parameters = todo_params
    todo_parameters = todo_parameters.to_h
    if Project.where(title: todo_parameters['project_title']).empty?
      project = Project.create(title: todo_parameters['project_title'])
      project.save
      todo_parameters['project_id'] = project.id
      puts 'hello'
    end
    todo_parameters.delete('project_title')
    todo = Todo.new(todo_parameters)
    if todo.save
      render json: { message: 'ok' }
    else
      render json: { message: todo.errors.messages }
    end
  end

  def update
    todo = Todo.find(todo_patch['todo_id'])
    if todo.isCompleted == false
      todo.isCompleted = true
    else
      todo.isCompleted = false
    end
    if todo.save
      render json: { message: 'ok' }
    else
      render json: { message: todo.errors.messages }
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
