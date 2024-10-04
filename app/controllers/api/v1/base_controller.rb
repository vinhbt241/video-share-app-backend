# frozen_string_literal: true

require 'jwt_token'

module API
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_request!

      def authenticate_request!
        return if current_user.present?

        render json: { message: 'Please log in' }, status: :unauthorized
      end

      def current_user
        return if decoded_token.blank?

        user_id = decoded_token['user_id']
        User.find_by(id: user_id)
      end

      def decoded_token
        header = request.headers['Authorization']
        return if header.blank?

        token = header.split(' ')[1]

        JwtToken.decode(token)
      end
    end
  end
end
