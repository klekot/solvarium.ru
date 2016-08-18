class ArticlesController < ApplicationController
  def index
    if user_signed_in?
      @articles_common  = Article.common.all
      @articles_my_own  = Article.where(user_id: current_user)
      @articles_project = Article.includes(:projects).where("projects.id" => current_user.current_project_id)
    else
      @articles_common  = Article.common.all
    end
    @tags = Tag.all
    @projects = Project.all
    @comments = Comment.all
  end

  def show
    if user_signed_in?
      @article = Article.find params[:id]
    else
      @article = Article.common.find params[:id]
    end
    @tags = Tag.all
    @projects = Project.all
    @comments = Comment.all
  end

  def new
  end

  def create
    @article = Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      add_current_project_to_article
      add_tags_to_article params.require(:article).permit(:tags)["tags"], @article.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find params[:id]
    tags = Tag.includes(:articles).where("articles.id" => @article.id)
    article_tags = []
    tags.each do |tag|
      article_tags.push(tag.name)
    end
    @tags_string = article_tags.join(", ")
    @my_projects = Project.where(user_id: current_user.id)
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes article_params
      add_projects_to_article params.require(:article).permit(:projects => []), @article.id
      add_tags_to_article params.require(:article).permit(:tags)["tags"], @article.id
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

  def add_current_project_to_article
    current_project = Project.find(current_user.current_project_id)
    @article.projects << current_project
  end
  
  def add_projects_to_article params_projects, article_id
    article_projects = []
    params_projects.flatten.join(',').split(',').each do |project|
      if Project.find_by(title: project.strip)
        p = Project.find_by(title: project.strip)
        p.save
        article_projects.push p
      end
      @article.projects.clear
    end
    @article.projects << article_projects
  end

  def add_tags_to_article params_tags, article_id
    article_tags = []
    params_tags.split(',').each do |tag|
      if Tag.find_by(name: tag.strip)
        t = Tag.find_by(name: tag.strip)
      else
        t = Tag.new name: tag.strip, user_id: current_user.id
      end
      t.save
      article_tags.push t
      @article.tags.clear
    end
    @article.tags << article_tags
  end
end
