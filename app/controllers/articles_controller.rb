class ArticlesController < ApplicationController
  def index
    if user_signed_in?
      @articles_common  = Article.common.all
      @articles_privat  = Article.privat.all
      @articles_project = Article.includes(:projects).where("projects.id" => current_user.current_project_id)
    else
      @articles_common  = Article.common.all
    end
  end

  def show
    if user_signed_in?
      @article = Article.find params[:id]
    else
      @article = Article.common.find params[:id]
    end
  end

  def new
  end

  def create
    @article = Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      add_projects_to_article
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit :subject, :content, :common
  end
  
  def add_projects_to_article
    projects = Project.find(current_user.current_project_id)
    @article.projects << projects
  end
end
