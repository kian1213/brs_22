class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  before_action :load_users, only: [:index]
  before_action :load_activities, only: [:show]

  private
  def load_users
    @users = @users.search(params[:search]).
      order(sort_column + " " + sort_direction).
      paginate per_page: 5, page: params[:page]
  end

  def load_activities
    @activities = Activity.order("created_at desc").
      current_user_activity @user.id
  end

  def sort_column
    User.column_names.include?(params[:sort]) ?
      params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end
end
