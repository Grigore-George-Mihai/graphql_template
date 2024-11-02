# frozen_string_literal: true

module HelpersConfig
  def response_body
    JSON.parse(response.body).with_indifferent_access
  end
end
