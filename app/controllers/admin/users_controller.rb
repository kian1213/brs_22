class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :load_users, only: [:index]

  def create
    if @user.save
      redirect_to admin_users_path
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      redirect_to admin_users_path
      flash[:success] = t ".success"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".success"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :first_name, :last_name, :email, :password,
      :admin, :avatar
  end

  def load_users
    @users = @users.order sort_column + " " + sort_direction
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
