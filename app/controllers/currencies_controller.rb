class CurrenciesController < ApplicationController
  def list
    result = ::Currencies::List.call

    currencies = result.map { |row| { date: row['date'], euro: row['euro'], dollar: row['dollar'] } }

    render json: currencies, status: :ok
  end
end
