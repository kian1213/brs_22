class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :load_requests, only: [:index]

  def create
    if @request.save request_params
      flash[:success] = t ".success"
      redirect_to admin_requests_path
    else
      render :new
    end
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t ".success"
      redirect_to admin_requests_path
    else
      render :edit
    end
  end

  def destroy
    @request = Request.find params[:id]
    @request.destroy
    flash[:success] = t ".success"
    redirect_to admin_requests_path
  end

  private
  def request_params
    params.require(:request).permit :user_id, :book_title, :book_author,
      :url, :status
  end

  def sort_column
    Request.column_names.include?(params[:sort]) ?
      params[:sort] : "book_title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end

  def load_requests
  @requests = @requests.search(params[:search]).
    order(sort_column + " " + sort_direction).
    paginate per_page: 5, page: params[:page]
  end
end
