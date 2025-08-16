# frozen_string_literal: true

namespace :security do
  desc "Run all security checks"
  task check: %i[security:bundler_audit security:brakeman]

  desc "Run Bundler Audit to check for vulnerable gems"
  task bundler_audit: :environment do
    sh "bundle exec bundle audit check --update"
  end

  desc "Run Brakeman to check for security vulnerabilities"
  task brakeman: :environment do
    # -q = quiet, -z = exit non-zero on any warnings (good for CI)
    sh "bundle exec brakeman -q -z"
  end
end
