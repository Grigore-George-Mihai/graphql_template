if defined? Dotenv && Rails.env.local?
  Dotenv.require_keys("JWT_SECRET", "SIDEKIQ_USERNAME", "SIDEKIQ_PASSWORD", "SIDEKIQ_SESSION_KEY") if Rails.env.development?
  Dotenv.require_keys("JWT_SECRET") if Rails.env.test?
end
