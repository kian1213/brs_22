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

  def destroy
    @favorite = Favorite.find params[:id]
    @favorite.destroy
    redirect_to books_path
    flash[:success] = t ".success"
  end

  private
  def favorite_params
    params.require(:favorite).permit :user_id, :book_id
  end
end
