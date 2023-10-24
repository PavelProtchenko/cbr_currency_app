require 'httparty'

class CurrencyParserService
  def initialize(date:)
    check_date(date)

    date = date
    url = "https://www.cbr.ru/scripts/XML_daily.asp?date_req=#{date}"
    @url_data = HTTParty.get(url)
  end

  def call
    parse_process
  end

  private

  def check_date(date)
    begin
      parsed_date = Date.parse(date)
      parsed_date
    rescue ArgumentError
      raise "Invalid date format"
    end
  end

  def extract_data(date, valute)
    date = date
    name = valute['Name']
    char_code = valute['CharCode']
    nominal = valute['Nominal']
    value = valute['VunitRate']
    validate_data(date, name, char_code, nominal, value)
  end

  def validate_data(date, name, char_code, nominal, value)
    if date.present? && char_code.present? && nominal.present? && name.present? && value.present?
      if char_code == 'EUR' || char_code == 'RUB' || char_code == 'USD'
        insert_currencies(date, name, char_code, nominal, value)
      end
    else
      puts 'Skipping a record due to missing or nil values'
    end
  end

  def insert_currencies(date, name, char_code, nominal, value)
    Currency.create(
      date: date,
      name: name,
      char_code: char_code,
      nominal: nominal,
      value: value
    )
  end

  def parse_process
    begin  
      @url_data['ValCurs']['Valute']&.each do |valute|
        extract_data(@url_data['ValCurs']['Date'], valute)
      end
    rescue StandardError => e
      puts "Error no data found: #{e.message}"
    end
  end
end
