class ProjectsController < ApplicationController
  before_action :correct_current_project, only: :destroy
  
  def index
    projects_shared  = Project.includes(:users).where('common' => 1, 'users.id' => current_user.id)
    @projects_common = (Project.where(common: 1) - projects_shared).sort_by(&:title)
    @projects_my_own = (Project.where(creator_id: current_user.id) + projects_shared).sort_by(&:title).uniq{|x| x.id}
  end

  def show
    @project = Project.find params[:id]
    @todos = Todo.where(user_id: current_user.id, project_id: params[:id])
    gon.project_id = params[:id]
    gon.user_id = current_user.id
  end

  def new
  end

  def create
    @project = Project.new project_params
    @project.creator_id = current_user.id
    @project.common = :params[:common]
    if @project.save
      if params[:project][:common] == '1'
        @project.users << current_user
      end
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
    @project = Project.find params[:id]
  end
  
  def update
    @project = Project.find params[:id]
    if @project.update_attributes project_params
      if params[:project][:common] == '1'
        @project.users << current_user
      end
      if params[:project][:current] == '1'
        current_user.current_project_id = @project.id
        current_user.save
      end
      redirect_to projects_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Project.destroy(params[:id])
    redirect_to projects_path
  end

  def change_current_project
    current_user.current_project_id = params["new_current_id"]
    current_user.save
    redirect_to articles_path
  end

  def join_project
    project = Project.find(params[:project_id])
    project.users << current_user
    redirect_to projects_path
  end

  def leave_project
    project = Project.find(params[:project_id])
    project.users.delete(current_user)
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit :title, :description, :common
  end
  
  def correct_current_project
    current_user.current_project_id = Project.first.id
    current_user.save
  end
end
