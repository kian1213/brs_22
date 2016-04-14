class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.admin?
      redirect_to admin_root_path
    end
  end
end
