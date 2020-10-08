# frozen_string_literal: true

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

  describe 'required tests for evaluation' do
    before(:each) do
      pricing_rules = { 'GR1' => { price: 3.11,
                                   rule: { min_quantity: 2,
                                           price_per: 2,
                                           price: 3.11 } },
                        'SR1' => { price: 5.00,
                                   rule: { min_quantity: 3,
                                           price_per: 1,
                                           price: 4.50 } },
                        'CF1' => { price: 11.23,
                                   rule: { min_quantity: 3,
                                           price_per: 1,
                                           price: 11.23 / 3 * 2 } } }
      @checkout = Checkout.new(pricing_rules)
    end

    it 'returns 22.45' do
      %w[GR1 SR1 GR1 GR1 CF1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 22.45
    end

    it 'returns 3.11' do
      %w[GR1 GR1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 3.11
    end

    it 'returns 16.61' do
      %w[SR1 SR1 GR1 SR1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 16.61
    end

    it 'returns 30.57' do
      %w[GR1 CF1 SR1 CF1 CF1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 30.57
    end

    # More needed tests

    it 'returns 18' do
      %w[SR1 SR1 SR1 SR1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 18
    end

    it 'returns 30.57' do
      %w[CF1 CF1 CF1 CF1 CF1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 37.43
    end

    it 'returns 30.57' do
      %w[CF1 CF1 CF1 CF1 CF1 CF1 CF1 CF1 CF1 CF1].each { |product| @checkout.scan(product) }
      expect(@checkout.total).to eq 74.86
    end
  end
end
