class BooksController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :load_books, only: [:index]
  before_action :load_reviews, only: [:show]
  before_action :load_list_and_favorite_books

  private
  def load_books
    @books = @books.search(params[:search]).
      order(sort_column + " " + sort_direction).
      paginate per_page: 5, page: params[:page]
  end

  def load_reviews
    @reviews = @book.reviews
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ?
      params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?
      params[:direction] : "asc"
  end

  def load_list_and_favorite_books
    if user_signed_in?
      @user_books = current_user.user_books.
        paginate per_page: 5, page: params[:page]
      @favorites = current_user.favorites.
        paginate per_page: 5, page: params[:page]
    end
  end
end
