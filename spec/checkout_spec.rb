# frozen_string_literal: true
require 'errors.rb'
require 'checkout.rb'

RSpec.describe Checkout do
  before(:each) do
    @pricing_rules = { 'GR1' => { price: 3.11,
                                  rule: { min_quantity: 0,
                                          price_per: 1,
                                          price: 3.11 } } }
  end

  describe 'simple transaction' do
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

      it 'returns 0.00' do
        co = Checkout.new(@pricing_rules)
        expect(co.total).to eq 0.00
      end
    end
  end

  describe 'validations' do
    it 'fails without rules' do
      expect { Checkout.new({}) }.to raise_error(Errors::RulesEmptyError)
    end

    it 'fails trying to add a wrong product' do
      co = Checkout.new(@pricing_rules)
      expect { co.scan('GR2') }.to raise_error(Errors::ProductNotFoundError)
    end

    it 'fails if product price is not informed' do
      @pricing_rules['GR1'].delete(:price)
      expect { Checkout.new(@pricing_rules) }.to raise_error(Errors::ProductPriceError)
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
