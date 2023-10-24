RSpec.describe Currencies::List, type: :model do
  describe '.call' do
    it 'returns the expected class type' do      
      result = ::Currencies::List.call

      expect(result).to be_an_instance_of(PG::Result)
    end
  end
end
