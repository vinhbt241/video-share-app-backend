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
require 'rails_helper'

RSpec.describe Video, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
