# frozen_string_literal: true

class JwtToken
  class << self
    def encode(payload)
      JWT.encode(payload, 'dev-backend')
    end

    def decode(token)
      JWT.decode(token, 'dev-backend')[0]
    rescue StandardError
      nil
    end
  end
end
