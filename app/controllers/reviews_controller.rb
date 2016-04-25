class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_rate_descriptions
  before_action :load_reviews, only: [:index]
  before_action :load_book, only: [:new, :edit]

  def create
    if @review.save review_params
      redirect_to user_reviews_path(current_user)
      @review.create_activity :create, owner: current_user
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def update
    @review = Review.find params[:id]

    if @review.update_attributes review_params
      redirect_to user_reviews_path(current_user)
      @review.create_activity :update, owner: current_user
      flash[:success] = t ".success"
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    flash[:success] = t ".success"
    redirect_to user_reviews_path
  end

  private
  def review_params
    params.require(:review).permit :book_id, :user_id, :content, :rate
  end

  def set_rate_descriptions
    @rate_descriptions = {"1": "Very Bad", "2": "Bad", "3": "Good",
        "4": "Very Good!", "5": "Excellent!"}
  end

  def load_reviews
    @reviews = current_user.reviews.paginate per_page: 5, page: params[:page]
  end

  def load_book
    if params[:action] == "new"
      @book = Book.find params[:book_id]
    else
      review = Review.find params[:id]
      @book = Book.find review.book.id
      params[:book_id] = @book.id
    end
  end
end
