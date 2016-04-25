class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    @types = ["followers", "following"]
    @title = t ".title"
    @user  = User.find params[:id]
    if params && @types.include?(params[:type])
      @users = @user.send(params[:type]).search(params[:search]).
        order(sort_column + " " + sort_direction).
        paginate page: params[:page], per_page: 10
      render "users/show_follow"
    else
      render file: "public/404.html", status: :not_found, layout: false
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    @user.create_activity :create, owner: current_user
    redirect_to users_path
  end

  def destroy
    @user = User.find params[:id]
    current_user.unfollow @user
    redirect_to users_path
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ?
      params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end
end
