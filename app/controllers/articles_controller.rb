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
    @comments = Comment.all
  end

  def show
    if user_signed_in?
      @article = Article.find params[:id]
    else
      @article = Article.common.find params[:id]
    end
    @tags = Tag.all
    @comments = Comment.all
  end

  def new
  end

  def create
    @article = Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      add_projects_to_article
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
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes article_params
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

  def add_projects_to_article
    projects = Project.find(current_user.current_project_id)
    @article.projects << projects
  end

  def add_tags_to_article params_tags, article_id
    article_tags = []
    params_tags.split(',').each do |tag|
      unless Tag.find_by(name: tag.strip)
        t = Tag.new name: tag.strip, user_id: current_user.id
        t.save
        article_tags.push t
      end
    end
    @article.tags << article_tags
  end
end
