class JsonWebToken

  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, expiry = 24.hours.from_now)
    payload[:exp] = expiry.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => error
    raise ExceptionHandler::InvalidToken, error.message
  end
end