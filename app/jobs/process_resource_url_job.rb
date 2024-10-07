# frozen_string_literal: true

class ProcessResourceUrlJob < ApplicationJob
  queue_as :default

  def perform(video_id:)
    video = Video.find(video_id)
    VideoServices::ProcessResourceUrlService.call(video:)
  end
end
