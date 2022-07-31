class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

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
      flash[:error] = "Comment needs to have actual content"
      redirect_to @commentable
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable unless @commentable.is_a?(Comment)
      redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @commentable unless @commentable.is_a?(Comment)
      redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
    else
      redirect_to @commentable, flash[:error] = "Something went wrong"
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
