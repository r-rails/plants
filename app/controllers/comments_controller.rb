class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Your comment has been added successfully'
      redirect_to plant_path(@comment.plant)
    else
      flash[:error] = @comment.errors.messages.first
      redirect_to plant_path(@comment.plant)
    end
  end

  private

  def comment_params
    params.permit(:body, :user_id, :plant_id)
  end
end