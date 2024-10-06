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
FactoryBot.define do
  factory :video do
    
  end
end
