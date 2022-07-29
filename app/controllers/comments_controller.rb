class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Your comment has been added successfully"
    else
      flash[:error] = "Comment needs to have actual content"
    end
    redirect_to plant_path(@comment.plant)
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html redirect_to plant_path(@comment.plant), notice: "The comment was updated"
      else
        format.html render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to plant_path(@comment.plant), status: :see_other
  end

  private
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.permit(:body, :user_id, :plant_id1)
  end
end
