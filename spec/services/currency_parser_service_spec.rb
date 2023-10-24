require 'rails_helper'

RSpec.describe CurrencyParserService, type: :service do
  let(:valid_date) { '09.02.2023' }
  let(:invalid_date) { 'invalid_date' }
  let(:sample_valute) do
    [
      {
        'Name' => 'Доллар США',
        'CharCode' => 'USD',
        'Nominal' => '1',
        'Value' => '71,5763'
      },
      {
        'Name' => 'Евро',
        'CharCode' => 'EUR',
        'Nominal' => '1',
        'Value' => '76,8344'
      }
    ]
  end

  describe '#initialize' do
    it 'creates an instance of the service' do
      service = CurrencyParserService.new(date: valid_date)
      expect(service).to be_a(CurrencyParserService)
    end

    it 'raises an error for an invalid date' do
      expect { CurrencyParserService.new(date: invalid_date) }
        .to raise_error("Invalid date format")
    end
  end

  describe '#call' do
    it 'parses and inserts data' do
      service = CurrencyParserService.new(date: valid_date)

      sample_valute.each do |valute|
        expect(Currency).to receive(:create).with(
          date: valid_date,
          name: valute['Name'],
          char_code: valute['CharCode'],
          nominal: valute['Nominal'],
          value: valute['Value']
        )
      end

      service.call
    end
  end
end
