class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rate_descriptions
  before_action :get_book, only: [:new, :edit]

  def index
    @reviews = current_user.reviews.paginate per_page: 5, page: params[:page]
  end

  def show
    @review = Review.find params[:id]
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params

    if @review.save
      redirect_to books_path
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def edit
    @review = Review.find params[:id]
  end

  def update
    @review = Review.find params[:id]

    if @review.update_attributes review_params
      redirect_to books_path
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
    @rate_descriptions = ["Very Bad", "Bad", "Good", "Very Good!", "Excellent!"]
  end

  def get_book
    if params[:action] == "new"
      @book = Book.find params[:book_id]
    else
      review = Review.find params[:id]
      @book = Book.find review.book.id
    end
  end
end
