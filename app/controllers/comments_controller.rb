class CommentsController < ApplicationController
  before_action :set_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to @commentable unless @commentable.is_a?(Comment)
      redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
      flash[:notice] = "Comment created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable unless @commentable.is_a?(Comment)
      redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
    else
      redirect_to @commentable, flash[:error] = "Something went wrong"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
