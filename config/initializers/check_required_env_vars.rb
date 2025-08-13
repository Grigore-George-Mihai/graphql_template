REQUIRED_ENV_VARS = if Rails.env.development? || Rails.env.production?
  %w[JWT_SECRET SIDEKIQ_USERNAME SIDEKIQ_PASSWORD SIDEKIQ_SESSION_KEY]
else
  %w[JWT_SECRET]
end.freeze

REQUIRED_ENV_VARS.each do |var|
  raise "#{var} is not set!" if ENV[var].blank?
end
