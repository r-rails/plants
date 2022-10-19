# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  # def new
  #   @comment = Comment.new
  # end

  # def show
  #   @comment = Comment.find(params[:id])
  # end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to @commentable
    else
      flash[:error] = "Comment needs to have actual content"
      redirect_to @commentable
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: "Comment updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted successfully."
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
