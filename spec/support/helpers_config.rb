# frozen_string_literal: true

# spec/support/request_helpers.rb
module HelpersConfig
  def response_body
    JSON.parse(response.body).with_indifferent_access
  end
end
