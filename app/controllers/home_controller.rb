class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.admin?
      redirect_to admin_root_path
    elsif user_signed_in? && !current_user.admin?
      @activities = Activity.order("created_at desc").
        current_user_activity current_user.id
    else
      @books = Book.includes(:book_images).all
    end
  end
end
