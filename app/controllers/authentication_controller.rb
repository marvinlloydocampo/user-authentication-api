class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    @user = User.find(username: login_params[:username]).first
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(username: @user.username)
      time = Time.now + 24.hours.to_i
      @user.success_login
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      @user.failed_login
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
