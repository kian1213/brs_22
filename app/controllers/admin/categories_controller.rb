class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :load_categories, only: [:index]
  before_action :authenticate_user!

  def create
    if @category.save
      redirect_to admin_categories_path
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      redirect_to admin_categories_path
      flash[:success] = t ".success"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t ".success"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_categories
    @categories = @categories.search(params[:search]).
      order(sort_column + " " + sort_direction).
      paginate per_page: 5, page: params[:page]
  end

  def sort_column
    User.column_names.include?(params[:sort]) ?
      params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end
end
