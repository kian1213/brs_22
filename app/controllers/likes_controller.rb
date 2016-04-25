class LikesController < ApplicationController
  load_and_authorize_resource

  def create
    @like = Like.new like_params
    @activity = Activity.find like_params[:activity_id]
    user = User.find @activity.owner_id

    if @like.save
      respond_to do |format|
        format.html {redirect_to user_path user}
        format.js
      end
    else
    end
  end

  def destroy
    @like = Like.find params[:id]
    @activity = Activity.find @like.activity_id
    user = User.find @activity.owner_id
    @like.destroy

    respond_to do |format|
      format.html {redirect_to user_path user}
      format.js
    end
  end

  private
  def like_params
    params.require(:like).permit :activity_id, :user_id
  end
end
