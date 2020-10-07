require 'checkout.rb'

RSpec.describe Checkout do
  describe 'simple transaction' do
    before(:each) do
      @pricing_rules = { 'GR1' => { price: 3.11,
                                    rule: { min_quantity: 0, discount: 0 } } }
    end

    context 'without pricing_rules' do
      it 'returns total of £3.11' do
        co = Checkout.new(@pricing_rules)
        co.scan('GR1')
        expect(co.total).to eq 3.11
      end

      it 'returns total of £6.22' do
        co = Checkout.new(@pricing_rules)
        co.scan('GR1')
        co.scan('GR1')
        expect(co.total).to eq 6.22
      end
    end
  end
end
