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
require 'rails_helper'

RSpec.describe Video, type: :model do
  # associations
  it { is_expected.to belong_to(:user) }

  # validations
  it { is_expected.to validate_presence_of(:resource_url) }

  # attributes
  it { is_expected.to define_enum_for(:status) }

  # callbacks
  describe 'callbacks' do
    let(:video) { build(:video) }

    context 'when the video is created' do
      it 'process resource url' do
        ActiveJob::Base.queue_adapter = :test
        expect { video.save }.to have_enqueued_job(ProcessResourceUrlJob)
      end
    end

    context 'when video status is updated to active' do
      let(:video) { build(:video) }

      it 'broadcast that video to NewVideo channel' do
        allow(VideoServices::ProcessResourceUrlService).to receive(:call)
        video.save
        video.reload
        expect do
          video.update(status: :active)
        end.to have_broadcasted_to('VideoChannel').with(VideoSerializer.render_as_json(video))
      end
    end
  end
end
