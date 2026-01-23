class UserController < ApplicationController
  before_action :authorize, only: [ :detail, :index, :save ]

  def authenticate
    result = UserServices::AuthenticateUser.call(
      username: params[:username],
      password: params[:password]
    )

    if result[:user_id]
      session["user_id"] = result[:user_id]
      redirect_to "/"
    else
      render :sign_in, status: :forbidden
    end
  end

  def create
    result = UserServices::CreateUser.call(
      username: params[:username],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      full_name: params[:full_name]
    )

    if result[:user_id]
      session["user_id"] = result[:user_id]
      redirect_to "/"
    else
      @error = result[:error]
      render :sign_up, status: :forbidden
    end
  end

  def detail
    @user = UserServices::GetUserDetail.call(user_id: params[:id])
  end

  def index
    @users = UserServices::GetUserList.call
  end

  def save
    if params[:submit] == "Edit"
      result = UserServices::UpdateUser.call(
        user_id: params[:id].to_i,
        username: params[:username],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        full_name: params[:full_name],
        dashboard: params[:dashboard] == "on",
        detection: params[:detection] == "on",
        balancing: params[:balancing] == "on",
        expense: params[:expense] == "on",
        category: params[:category] == "on",
        session_user_id: session["user_id"].to_i,
      )
    end

    if params[:submit] == "Remove"
      result = UserServices::DeleteUser.call(
        user_id: params[:id].to_i,
        session_user_id: session["user_id"].to_i
      )
    end

    if result[:error] == nil
      redirect_to "/user"
    else
      @error = result[:error]
      @user = UserServices::GetUserDetail.call(user_id: params[:id])
      render :detail, status: :forbidden
    end
  end

  def sign_in
    reset_session
  end

  def sign_up
    reset_session
  end
end
