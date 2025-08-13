# frozen_string_literal: true

class JwtService
  JWT_SECRET = ENV.fetch("JWT_SECRET", nil)

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, JWT_SECRET, "HS256")
    end

    def authenticate(headers)
      token = extract_bearer_token(headers)
      payload = decode(token)

      user = User.find_by(id: payload[:user_id])
      raise ErrorHandler::JwtVerificationError unless user&.jti == payload[:jti]

      user
    end

    private

    def extract_bearer_token(headers)
      auth_header = headers["Authorization"]
      raise ErrorHandler::JwtDecodeError unless auth_header&.start_with?("Bearer ")

      auth_header.split.last
    end

    def decode(token)
      body = JWT.decode(token, JWT_SECRET, true, algorithm: "HS256")[0]
      ActiveSupport::HashWithIndifferentAccess.new(body)
    rescue JWT::ExpiredSignature
      raise ErrorHandler::JwtExpiredError
    rescue JWT::DecodeError
      raise ErrorHandler::JwtDecodeError
    end
  end
end
