class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end

  def new
  end

  def create
    @article = Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      @projects = Project.where(id: current_user.current_project_id)
      @article.projects << @projects
      redirect_to @article
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit :subject, :content
  end
end
