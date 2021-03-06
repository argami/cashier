# frozen_string_literal: true

require 'product.rb'
require 'rule.rb'

RSpec.describe Rule do
  before(:each) do
    @product = Product.new 'GR1', 3.11
  end

  describe '#new' do
    it 'should set up the defaults values ' do
      rule = Rule.new @product
      expect(rule.code).to eq @product.code
      expect(rule.minimun).to eq 0
      expect(rule.per).to eq 1
      expect(rule.price).to eq @product.price
      expect(rule.active?).to be_falsey
    end

    it 'returns the passed values' do
      rule = Rule.new @product, minimun: 2, per: 2, price: 4.11
      expect(rule.code).to eq @product.code
      expect(rule.minimun).to eq 2
      expect(rule.per).to eq 2
      expect(rule.price).to eq 4.11
      expect(rule.active?).to be_truthy
    end

    it 'fails if price is a negative value' do
      expect { Rule.new @product, price: -1 }.to raise_error(ArgumentError)
    end
  end

  describe '#apply' do
    it 'returns the total (6.22) without applying the rule' do
      rule = Rule.new @product, minimun: 0, per: 2, price: 3.11
      expect(rule.apply(quantity: 2)).to eq 6.22
    end

    it 'apply the rule and return 3.11' do
      rule = Rule.new @product, minimun: 2, per: 2, price: 3.11
      expect(rule.apply(quantity: 2)).to eq 3.11
    end
  end
end
