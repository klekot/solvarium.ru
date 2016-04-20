class ProjectsController < ApplicationController
  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def show
    @project = Project.find params[:id]
  end

  def new
  end

  def create
    @project = Project.new project_params
    @project.user_id = current_user.id
    if @project.save
      if params[:project][:current] == '1'
        current_user.current_project_id = @project.id
        current_user.save
      end
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def project_params
    params.require(:project).permit :title, :description
  end
end
