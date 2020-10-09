# frozen_string_literal: true

require 'rule.rb'
require 'rules.rb'
require 'product.rb'
require 'errors.rb'
require 'checkout.rb'

RSpec.describe Checkout do
  before(:each) do
    gr1 = Product.new('GR1', 3.11)
    sr1 = Product.new('SR1', 5.00)
    cf1 = Product.new('CF1', 11.23)
    gr2 = Product.new('GR2', 3.11)
    pricing_rules = Rules.new
    [
      Rule.new(gr1, minimun: 2, per: 2, price: 3.11),
      Rule.new(sr1, minimun: 3, per: 1, price: 4.50),
      Rule.new(cf1, minimun: 3, per: 1, price: 11.23 / 3 * 2),
      Rule.new(gr2),
    ].each { |r| pricing_rules.add(r) }
    @checkout = Checkout.new(pricing_rules)
  end

  describe 'simple transaction' do
    context 'without pricing_rules' do
      it 'returns total of £3.11' do
        @checkout.scan('GR2')
        expect(@checkout.total).to eq 3.11
      end

      it 'returns total of £6.22' do
        @checkout.scan('GR2')
        @checkout.scan('GR2')
        expect(@checkout.total).to eq 6.22
      end

      it 'returns 0.00' do
        expect(@checkout.total).to eq 0.00
      end
    end
  end

  describe 'validations' do
    it 'fails without rules' do
      expect { Checkout.new([]) }.to raise_error(Errors::RulesEmptyError)
    end
  end

  describe 'required tests for evaluation' do
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

    # More tests needed

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
