# frozen_string_literal: true

module API
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate_request!, only: [:create]
      before_action :prepare_user, only: [:show]

      def create
        user = User.create!(user_params)

        render_resource(user, view: :with_token, status: :created)
      end

      def show
        render_resource(@user)
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def prepare_user
        @user = User.find(params[:id])
      end
    end
  end
end
