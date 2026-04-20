# frozen_string_literal: true

class JwtToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.credentials[:jwt_secret])
    end

    def decode(token)
      JWT.decode(token, Rails.application.credentials[:jwt_secret])[0]
    rescue StandardError
      nil
    end
  end
end
