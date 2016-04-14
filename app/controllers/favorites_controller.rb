class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new favorite_params

    if @favorite.save
      redirect_to books_path
      flash[:success] = t ".success"
    else
      redirect_to books_path
      flash[:danger] = t ".fail"
    end
  end

  private
  def favorite_params
    params.require(:favorite).permit :user_id, :book_id
  end
end
