# frozen_string_literal: true

require 'rails_helper'

describe VideoServices::ProcessResourceUrlService do
  describe '#call' do
    context 'when resource_url is blank' do
      it 'raise error' do
        video = Video.new
        expect do
          described_class.call(video:)
        end.to raise_error(VideoServices::ProcessResourceUrlService::ResourceURLMissingError)
      end
    end

    context 'when resource_url is present' do
      let(:video) { build(:video) }
      let(:yt_instance) do
        instance_double(
          Yt::Video,
          title: 'test title',
          like_count: 1,
          description: '...',
          id: '123'
        )
      end

      it 'call Youtube API to populate attributes' do
        allow(Yt::Video).to receive(:new).and_return(yt_instance)

        described_class.call(video:)

        expect(Yt::Video).to have_received(:new).twice.with(url: video.resource_url)
      end
    end
  end
end
