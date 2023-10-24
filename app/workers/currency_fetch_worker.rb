require 'sidekiq-scheduler'

class CurrencyFetchWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 2

  def perform
    ::CurrencyParserService.new(date: DateTime.now.strftime('%d/%m/%Y')).call
  end
end
