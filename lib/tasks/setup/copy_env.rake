# frozen_string_literal: true

namespace :setup do
  desc "Create .env.development/.env.test from their .template files (never overwrite)"
  task copy_env: :environment do
    root = Rails.root
    pairs = {
      development: [root.join(".env.development.template"), root.join(".env.development")],
      test: [root.join(".env.test.template"), root.join(".env.test")]
    }

    pairs.each do |env, (template, dest)|
      unless File.exist?(template)
        puts "⚠️  Missing template for #{env}: #{template}"
        next
      end

      if File.exist?(dest)
        puts "⏭️  Skipped (exists): #{dest}"
        next
      end

      File.write(dest, File.read(template))
      begin
        File.chmod(0o600, dest)
      rescue StandardError => e
        warn "⚠️  Could not set permissions on #{dest}: #{e.message}"
      end

      puts "✅ Created #{dest} from #{template}"
    end
  end
end
