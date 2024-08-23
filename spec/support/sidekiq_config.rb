# frozen_string_literal: true

require "rspec-sidekiq"

RSpec.configure do |config|
  # Clear all job queues before each example
  config.before do
    Sidekiq::Worker.clear_all
  end
end
