Rails.application.config.middleware.insert_before 0, Rack::Cors do

  allow do

    origins ENV['CLIENT_URL'] ? ENV['CLIENT_URL'].split(',').map { |origin| origin.strip } : '0.0.0.0:8000'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      expose: %w(Authorization),
      max_age: 600
  end
end
