# frozen_string_literal: true

if defined?(Bullet)
  Bullet.enable = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
  Bullet.add_footer = true

  Bullet.alert = true if Rails.env.development?

  Bullet.raise = true if Rails.env.test?
end
