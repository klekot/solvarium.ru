class CommentsController < ApplicationController
  def new
  end
  
  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]
    if @comment.update_attributes comment_params
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    Comment.destroy(params[:id])
    redirect_to articles_path
  end
  
  private

  def comment_params
    params.require(:comment).permit :content, :article_id
  end
end
