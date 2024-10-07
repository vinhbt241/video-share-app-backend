# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        collection do
          get :me
        end
      end
      resources :sessions, only: [:create]
      resources :videos, only: %i[index create]
    end
  end
end
