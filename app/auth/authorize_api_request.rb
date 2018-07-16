class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { user: user }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find_by_email!(decoded_auth_token[:user_email]) if decoded_auth_token

  rescue ActiveRecord::RecordNotFound => error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{error.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers[:Authorization].present?
      headers[:Authorization].split(' ').last
    else
      raise(
        ExceptionHandler::MissingToken, Message.missing_token
      )
    end
  end
end
