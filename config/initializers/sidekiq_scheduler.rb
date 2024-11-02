Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = Rails.root.join("config/scheduler/#{Rails.env}.yml")

    if File.exist?(schedule_file)
      Sidekiq.schedule = YAML.load_file(schedule_file)
      SidekiqScheduler::Scheduler.instance.reload_schedule!
    else
      Rails.logger.info "No schedule file found for #{Rails.env}. Skipping job scheduling."
    end
  end
end
