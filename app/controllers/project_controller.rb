class ProjectController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: JSON.parse(Project.all.to_json(include: :todos))
  end

  def create_todo
    todo_parameters = todo_params
    todo_parameters = todo_parameters.to_h
    if Project.where(title: todo_parameters['project_title']).empty?
      project = Project.new(title: todo_parameters['project_title'])
      project.save
      project_id = project.id
      todo_parameters['project_id'] = project.id
    else
      project_id = Project.where(title: todo_parameters['project_title']).first.id
    end
    todo_parameters.delete('project_title')
    todo = Todo.new(text: todo_parameters['text'], project_id: project_id)
    if todo.save
      render json: {message: 'ok'}
    else
      render json: {message: todo.errors.messages}
    end
  end

  def update
    todo = Todo.find(todo_patch['todo_id'])
    todo.isCompleted = !todo.isCompleted

    if todo.save
      render json: {message: 'ok'}
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
