# frozen_string_literal: true

RSpec.configure do |config|
  next unless defined?(Bullet)

  config.around do |example|
    if example.metadata[:bullet] == false
      prev_enable = Bullet.enable?
      Bullet.enable = false
      example.run
      Bullet.enable = prev_enable
    else
      Bullet.start_request
      example.run
      Bullet.perform_out_of_channel_notifications if Bullet.notification? && Bullet.raise
      Bullet.end_request
    end
  end
end
