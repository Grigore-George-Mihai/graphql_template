# frozen_string_literal: true

namespace :setup do
  desc "Ask for new app name and update known files"
  task rename_app: :environment do
    print "Enter the new app name (Title Case, e.g. My New App): "
    new_title = $stdin.gets&.strip.to_s
    abort("❌ App name cannot be empty!") if new_title.empty?

    old_title       = Rails.application.name.titleize
    old_title_camel = old_title.delete(" ")
    old_title_snake = old_title.parameterize(separator: "_")

    new_title       = new_title.titleize
    new_title_camel = new_title.delete(" ")
    new_title_snake = new_title.parameterize(separator: "_")

    puts "Using:\n  Title : #{new_title}\n  snake : #{new_title_snake}\n  Camel : #{new_title_camel}"

    replace_patterns = [
      # Title Case (strict word boundaries)
      [/\b#{Regexp.escape(old_title)}\b/, new_title],

      # CamelCase
      [/\b#{Regexp.escape(old_title_camel)}\b/, new_title_camel],
      [/#{Regexp.escape(old_title_camel)}/, new_title_camel],

      # snake_case
      [/\b#{Regexp.escape(old_title_snake)}\b/, new_title_snake],
      [/#{Regexp.escape(old_title_snake)}/, new_title_snake]
    ]

    files = %w[
      .ruby-gemset
      .env.development.template
      app/views/pwa/manifest.json.erb
      app/controllers/graphql_controller.rb
      app/graphql/graphql_template_schema.rb
      config/application.rb
      config/cable.yml
      config/database.yml
      config/environments/production.rb
      config/scout_apm.yml
      docker-compose.yml
    ]

    changed = 0
    files.each do |file|
      path = Rails.root.join(file)
      next unless File.exist?(path)

      text = File.read(path)
      updated = replace_patterns.reduce(text) { |acc, (from, to)| acc.gsub(from, to) }
      next if updated == text

      File.write(path, updated)
      puts "Updated: #{file}"
      changed += 1
    end

    puts "✅ Done. Files updated: #{changed}"
  end
end
