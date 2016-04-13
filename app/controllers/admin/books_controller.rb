class Admin::BooksController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :load_books, only: [:index]
  before_action :load_categories, except: [:index, :destroy]
  before_action :authenticate_user!
  before_action :build_book_images, only: [:new]

  def create
    if @book.save
      params[:book_images][:image].each do |image|
        @book_images = @book.book_images.
          create!(image: image, book_id: @book.id)
      end
      redirect_to admin_books_path
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def update
    if @book.update_attributes book_params
      redirect_to admin_books_path
      flash[:success] = t ".success"
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:success] = t ".success"
    redirect_to admin_books_path
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :published_date,
      :total_page, :category_id, book_images_attributes: [:id, :image, :_destroy]
  end

  def load_categories
    @categories = Category.all
  end

  def load_books
    @books = @books.search(params[:search]).
      order(sort_column + " " + sort_direction).
      paginate per_page: 5, page: params[:page]
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ?
      params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end

  def build_book_images
    @book_images = @book.book_images.build
  end
end
