class HomeController < ApplicationController
  before_action :authorize

  def index
    @user = UserServices::GetUserDetail.call(user_id: session[:user_id])
    @year = YearServices::GetYearDetail.call(year_id: session[:year_id])
  end
end
