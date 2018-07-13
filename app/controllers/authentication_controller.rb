class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :login
  skip_before_action :authorize_request, only: :register
  def login
    token =
      AuthenticateUser.new(login_params[:email], login_params[:password]).call
    render json: { auth_token: token }, status: :ok
  end

  def register
    user = User.create!(register_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    render json: response, status: :created
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def register_params
    params.permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
