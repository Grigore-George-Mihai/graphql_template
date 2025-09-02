require "sidekiq-scheduler"

Sidekiq.configure_server do |config|
  config.on(:startup) do
    if Rails.env.test?
      Rails.logger.info "Skipping Sidekiq scheduler in test environment."
    else
      schedule_path = Rails.root.join("config", "scheduler", "#{Rails.env}.yml")

      if File.exist?(schedule_path)
        yaml = YAML.safe_load_file(schedule_path, aliases: true)
        schedule = yaml.fetch("schedule") { {} }

        Sidekiq.schedule = schedule
        SidekiqScheduler::Scheduler.instance.reload_schedule!

        Rails.logger.info "Loaded Sidekiq schedule with #{schedule.keys.size} job(s): #{schedule.keys.join(', ')}"
      else
        Rails.logger.info "No schedule file found for #{Rails.env}. Skipping job scheduling."
      end
    end
  end
end
