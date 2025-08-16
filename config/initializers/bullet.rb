Rails.application.configure do
  config.after_initialize do
    next unless defined?(Bullet) && Rails.env.local?

    Bullet.enable        = true
    Bullet.bullet_logger = true
    Bullet.rails_logger  = true

    if Rails.env.development?
      Bullet.console     = true
      Bullet.alert       = true
      Bullet.add_footer  = true
    end

    if Rails.env.test?
      Bullet.raise       = true
      # Bullet.rollbar  = true
    end
  end
end
