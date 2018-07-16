module AuthorizeApiRequestHelper
  def token_generator(user_email)
    JsonWebToken.encode(user_email: user_email)
  end

  def expired_token_generator(user_email)
    JsonWebToken.encode(
      { user_email: user_email }, (Time.now - 10)
    )
  end

  def valid_headers
    {
      Authorization: token_generator(user.email),
      'Content-Type' => 'Application/json'
    }
  end

  def invalid_headers
    {
      Authorization: nil,
      'Content-Type' => 'Application/json'
    }
  end
end
