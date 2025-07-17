class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_user_token

  private
  def set_user_token
    session[:user_token] ||= SecureRandom.uuid
  end
end
