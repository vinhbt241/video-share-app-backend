# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id           :uuid             not null, primary key
#  user_id      :uuid
#  resource_url :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Video < ApplicationRecord
  # associations
  belongs_to :user

  # validations
  validates :resource_url, presence: true

  # attributes
  enum status: { created: 0, active: 1 }

  # callbacks
  after_create :process_resource_url
  before_update :broadcast_new_active_video

  def process_resource_url
    VideoServices::ProcessResourceUrlService.call(video: self)
  end

  def broadcast_new_active_video
    return unless status_changed? && active?

    ActionCable.server.broadcast(
      'VideoChannel',
      VideoSerializer.render_as_json(self)
    )
  end
end
