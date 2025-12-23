class HomeController < ApplicationController
  before_action :authorize

  def index
    @user = UserServices::GetUserDetail.call(user_id: session[:user_id])
  end
end
