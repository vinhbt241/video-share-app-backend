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

  # scopes
  scope :active, -> { where(active: true) }

  # callbacks
  after_create :process_resource_url

  def process_resource_url
    VideoServices::ProcessResourceUrlService.call(video: self)
  end
end
