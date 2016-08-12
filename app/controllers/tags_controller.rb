class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tags = @tags.sort_by &:name
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = Article.includes(:tags).where('tags.id' => @tag.id)
  end

  def create
  end

  def edit
  end
end
