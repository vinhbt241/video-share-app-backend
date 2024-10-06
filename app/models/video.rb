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
  belongs_to :user

  validates :resource_url, presence: true
end
