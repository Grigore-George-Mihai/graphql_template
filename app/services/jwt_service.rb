# frozen_string_literal: true

class JwtService
  SECRET_KEY = Rails.application.credentials.secret_key_base || ENV.fetch("SECRET_KEY_BASE") { raise "Secret key base not configured" }

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY, true, algorithm: "HS256")[0]
    payload = ActiveSupport::HashWithIndifferentAccess.new(body)

    raise ErrorHandler::JwtVerificationError, "Invalid JTI in JWT token" unless valid_jti?(payload)

    payload
  rescue JWT::ExpiredSignature
    raise ErrorHandler::JwtExpiredError
  rescue JWT::DecodeError => e
    raise ErrorHandler::JwtDecodeError, e.message
  end

  def self.valid_jti?(payload)
    user = User.find_by(id: payload[:user_id])
    user&.jti == payload[:jti]
  end
end
