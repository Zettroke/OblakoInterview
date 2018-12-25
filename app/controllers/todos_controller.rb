class TodosController < ApplicationController
  protect_from_forgery except: :update
  def index
    @projects = Project.all
  end

  def create

    todo = Todo.new text: params[:text], project_id: params[:project_id]
    todo.isCompleted = false
    todo.save
    redirect_to root_path
  end

  def update
    todo = Todo.find_by id: params[:id].to_i
    todo.isCompleted = !todo.isCompleted
    todo.save

    redirect_to root_path
  end

  def get_projects
    render json: Project.all.to_json(:include => :todos)
  end


end
