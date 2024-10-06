# frozen_string_literal: true

module VideoServices
  class ProcessResourceUrlService < ApplicationService
    def initialize(video:)
      @video = video
    end

    def call
      raise ResourceURLMissingError if @video.resource_url.blank?

      ActiveRecord::Base.transaction do
        yt_video = Yt::Video.new(url: @video.resource_url)
        @video.update(
          title: yt_video.title,
          likes: yt_video.like_count,
          description: yt_video.description,
          embedded_id: yt_video.id,
          active: true
        )
      end
    end

    ResourceURLMissingError ||= Class.new(StandardError)
  end
end
