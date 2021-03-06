class UserBooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_book = UserBook.new user_book_params

    if @user_book.save
      redirect_to books_path
      flash[:success] = t ".success"
    else
      redirect_to books_path
      flash[:danger] = t ".fail"
    end
  end

  def update
    @user_book = UserBook.find params[:id]

    if @user_book.update_attributes user_book_params
      redirect_to books_path
      flash[:success] = t ".success"
    else
      redirect_to books_path
      flash[:danger] = t ".fail"
    end
  end

  private
  def user_book_params
    params.require(:user_book).permit :user_id, :book_id, :status
  end
end
