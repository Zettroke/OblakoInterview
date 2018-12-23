class TodosController < ApplicationController
  def index
    @projects = Project.all
  end

  def create

    todo = Todo.new params.require(:todo).permit(:text, :project_id)
    todo.isCompleted = false
    todo.save
    redirect_to root_path
  end
end
