class TagsController < ApplicationController
  def index
    @tags = Tag.all.to_a
    @tags.sort! { |a,b| a.name.downcase <=> b.name.downcase }
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
