class ArticlesController < ApplicationController
  def index
    if user_signed_in?
      @articles_common  = Article.common.all
      @articles_my_own  = Article.where(user_id: current_user)
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
      add_tags_to_article params.require(:article).permit(:tags)["tags"]
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
    @article = Article.find params[:id]
  end
  
  def update
    @article = Article.find params[:id]
    if @article.update_attributes article_params
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Article.destroy(params[:id])
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit :subject, :content, :common
  end
  
  def add_projects_to_article
    projects = Project.find(current_user.current_project_id)
    @article.projects << projects
  end
  
  def add_tags_to_article params_tags
    tags = []
    params_tags.split(',').each do |tag|
      t = Tag.new name: tag.strip, user_id: current_user.id
      t.save
      tags.push t
    end
    @article.tags << tags
  end
end
