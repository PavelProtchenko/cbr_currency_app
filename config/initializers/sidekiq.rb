require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') + '/0' }
  config.average_scheduled_poll_interval = 1
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../schedule.yml', __FILE__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL') + '/0' }
# end

ActiveJob::Base.logger = Logger.new(IO::NULL)
