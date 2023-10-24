require 'rails_helper'

RSpec.describe 'Currencies', type: :request do
  before do
    Currency.create(date: '24-10-2023', char_code: 'EUR', nominal: 1, value: 50.0, name: 'Sample Name')
  end

  describe 'GET #list' do
    it 'returns a JSON response with currency data' do
      get '/list'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)

      expect(json_response).to be_an(Array)
      expect(json_response.first).to have_key('date')
      expect(json_response.first).to have_key('euro')
      expect(json_response.first).to have_key('dollar')
    end
  end
end
