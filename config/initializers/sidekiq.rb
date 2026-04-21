# frozen_string_literal: true

redis_url =
  ENV['REDIS_URL'] ||
  Rails.application.credentials.dig(:redis, :url)

if redis_url.nil? && Rails.env.production?
  # Allow asset precompile (build phase) to pass
  raise('Missing Redis URL') unless ENV['SECRET_KEY_BASE_DUMMY']

  redis_url = 'redis://localhost:6379/1'
end

sidekiq_config = {
  url: redis_url,
  network_timeout: 5,
  pool_timeout: 5,
  size: ENV.fetch('RAILS_MAX_THREADS', 5).to_i
}

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
