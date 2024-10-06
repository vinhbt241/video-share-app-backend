# frozen_string_literal: true

class VideoChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug('user is online!')
    stream_from 'VideoChannel'
  end

  def unsubscribed
    Rails.logger.debug('user is offline!')
  end
end
