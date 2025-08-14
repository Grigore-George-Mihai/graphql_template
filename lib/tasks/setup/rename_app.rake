# frozen_string_literal: true

namespace :setup do
  desc "Ask for new app name and update known files"
  task rename_app: :environment do
    print "Enter the new app name (Title Case, e.g. My New App): "
    new_title = $stdin.gets&.strip.to_s
    abort("❌ App name cannot be empty!") if new_title.empty?

    new_snake = new_title.parameterize(separator: "_")
    new_camel = new_title.delete(" ")

    puts "Using:\n  Title : #{new_title}\n  snake : #{new_snake}\n  Camel : #{new_camel}"

    replace_patterns = [
      [/\bGraphql Template\b/, new_title], # Title Case
      [/\bGraphqlTemplate\b/,  new_camel], # CamelCase
      [/\bgraphql_template\b/, new_snake], # snake_case (strict)
      [/graphql_template/,     new_snake] # snake_case (loose)
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
