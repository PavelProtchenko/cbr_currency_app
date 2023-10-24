require 'rails_helper'

RSpec.describe Currency, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:date).scoped_to(:value, :char_code, :name, :nominal) }
  end

  describe 'uniqueness validation' do
    let(:valid_attributes) do
      {
        date: '2023-10-24',
        value: '63.0',
        char_code: 'JPY',
        name: 'Японских иен',
        nominal: 100
      }
    end

    it 'is valid with unique attributes' do
      expect(described_class.new(valid_attributes)).to be_valid
    end

    it 'is invalid with non-unique attributes' do
      # Create a record with the same attributes
      described_class.create(valid_attributes)

      # Attempt to create a duplicate record
      duplicate_currency = described_class.new(valid_attributes)

      expect(duplicate_currency).not_to be_valid
      expect(duplicate_currency.errors[:date]).to include('has already been taken')
    end
  end
end
