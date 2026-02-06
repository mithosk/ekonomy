class YearController < ApplicationController
  before_action :authorize

  def detail
    @year = YearServices::GetYearDetail.call(year_id: params[:id])
  end

  def index
    @years = YearServices::GetYearList.call
  end

  def save
    if params[:submit] == "Edit"
      result = YearServices::UpdateYear.call(
        year_id: params[:id].to_i,
        target: params[:target],
        session_user_id: session["user_id"].to_i,
        ref_date: Date.today
      )

      if result[:error] == nil
        redirect_to "/year"
      else
        @error = result[:error]
        @year = YearServices::GetYearDetail.call(year_id: params[:id])
        render :detail, status: :forbidden
      end
    end

    if params[:submit] == "Switch"
      session["year_id"] = params[:id].to_i
      redirect_to "/"
    end
  end
end
