class TodosController < ApplicationController
  def index
    @projects = Project.all
  end

  def create

    Todo.create params.require(:todo).permit(:text, :project_id)
    redirect_to root_path
  end
end
