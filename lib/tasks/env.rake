# frozen_string_literal: true

namespace :env do
  desc "Create new .env files from .env.template files"
  task setup: :environment do
    development_template = ".env.development.template"
    test_template = ".env.test.template"
    development_file = ".env.development"
    test_file = ".env.test"

    if File.exist?(development_template)
      File.write(development_file, File.read(development_template)) unless File.exist?(development_file)
      puts "Created #{development_file} from #{development_template}"
    else
      puts "#{development_template} does not exist!"
    end

    if File.exist?(test_template)
      File.write(test_file, File.read(test_template)) unless File.exist?(test_file)
      puts "Created #{test_file} from #{test_template}"
    else
      puts "#{test_template} does not exist!"
    end
  end
end
