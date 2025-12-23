class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  stale_when_importmap_changes

  def authorize
    redirect_to "/user/sign-in" unless session[:user_id].present?
  end
end
