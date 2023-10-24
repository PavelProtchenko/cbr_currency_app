require 'rails_helper'

RSpec.describe CurrencyFetchWorker, type: :worker do
  it 'enqueues a job' do
    Sidekiq::Testing.fake!

    CurrencyFetchWorker.perform_async

    expect(CurrencyFetchWorker.jobs.size).to eq(1)
  end
end
