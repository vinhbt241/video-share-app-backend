# frozen_string_literal: true

class VideoChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'VideoChannel'
  end

  def unsubscribed; end
end
