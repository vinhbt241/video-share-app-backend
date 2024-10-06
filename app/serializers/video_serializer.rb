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
class VideoSerializer < ApplicationSerializer
  identifier :id

  fields :title,
         :description,
         :embedded_id,
         :likes

  field :created_by do |video|
    video.user.email
  end
end
