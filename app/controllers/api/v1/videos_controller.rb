# frozen_string_literal: true

module API
  module V1
    class VideosController < BaseController
      skip_before_action :authenticate_request!, only: [:index]

      def index
        video = Video.active.order(created_at: :desc)

        render_resource_collection(video, each_serializer: VideoSerializer)
      end

      def create
        video = Video.create!(video_params)

        render_resource(video, status: :created)
      end

      def me
        render_resource(current_user)
      end

      private

      def video_params
        params.require(:video).permit(:resource_url).merge(user: current_user)
      end
    end
  end
end
