class ProjectController < ApplicationController
  def index
    render json: {message: 'neok'}
  end
end
