namespace :import do
  desc 'Import currency data from JSON'
  task last_month_currencies: :environment do
    start_date = 1.month.ago.to_date
    end_date = Date.today.to_date
    date_range = start_date..end_date
    date_range.each do |date|
      puts "\n\n-----\n\n#{date.strftime('%d/%m/%Y')}"
      ::CurrencyParserService.new(date: date.strftime('%d/%m/%Y')).call
    end
  end
end
