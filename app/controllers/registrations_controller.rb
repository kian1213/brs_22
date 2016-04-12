class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create, :update]

  protected
  def configure_permitted_parameters
    actions = ["sign_up", "account_update"]
    actions.each do |action|
      devise_parameter_sanitizer.for(action.to_sym) {|user|
        user.permit(:first_name, :last_name, :email, :password,
        :avatar, :current_password)}
    end
  end
end
