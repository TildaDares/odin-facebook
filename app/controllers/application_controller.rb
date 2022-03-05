class ApplicationController < ActionController::Base
  include ActionView::Helpers::DateHelper
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password) }
  end

  def send_notification(message, user, link)
    unless user == current_user # prevents user from sending notification to itself
      @notif = user.notifications.build(message: message, url: link, sender_id: current_user.id)
      @notif.save
    end
  end
end
