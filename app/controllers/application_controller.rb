class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
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
