class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout

  private
  def layout
    "application"
    if user_signed_in? && current_user.admin?
      "admin"
    end
  end
end
