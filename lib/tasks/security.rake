# frozen_string_literal: true

namespace :security do
  desc "Run all security checks"
  task check: %w[security:bundler_audit security:brakeman]

  desc "Run Bundler Audit to check for vulnerable gems"
  task bundler_audit: :environment do
    sh "bundle audit"
  end

  desc "Run Brakeman to check for security vulnerabilities"
  task brakeman: :environment do
    sh "brakeman"
  end
end
