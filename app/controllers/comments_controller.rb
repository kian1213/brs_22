class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    if @comment.save comment_params
      @review = Review.find params[:review_id]
      respond_to do |format|
        format.html {redirect_to user_review_path(params[:user_id], params[:review_id])}
        format.js
      end
    else
    end
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    if @comment.update_attributes comment_params
      @review = Review.find params[:review_id]
      respond_to do |format|
        format.html {redirect_to user_review_path(params[:user_id], params[:review_id])}
        format.js
      end
    else
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      @review = Review.find params[:review_id]
      format.html {redirect_to user_review_path(params[:user_id], params[:review_id])}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end
end
