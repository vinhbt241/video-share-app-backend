# frozen_string_literal: true

module API
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate_request!, only: [:create]

      def create
        user = User.create!(user_params)

        render_resource(user, view: :with_token, status: :created)
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
