# frozen_string_literal: true

require 'swagger_helper'

describe 'Video APIs' do
  path '/api/v1/videos' do
    get 'get all video with active status' do
      tags 'Videos'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end

    post 'create new video' do
      tags 'Videos'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          video: {
            type: :object,
            properties: {
              resource_url: { type: :string }
            },
            required: ['resource_url']
          }
        },
        required: ['video']
      }
      security [bearer_auth: {}]

      response '201', 'video created' do
        let!(:user) { create(:user) }
        let(:Authorization) { "Bearer #{user.jwt_token}" }
        let(:params) { { video: { resource_url: 'http://example-video.com' } } }

        before { allow(VideoServices::ProcessResourceUrlService).to receive(:call) }

        run_test!
      end

      response '401', 'not authenticated' do
        let(:Authorization) {}
        let(:params) { { video: { resource_url: 'http://example-video.com' } } }

        run_test!
      end
    end
  end
end
