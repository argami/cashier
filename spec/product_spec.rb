# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  describe '#new' do
    it 'requires product code' do
      expect { Product.new }.to raise_error(ArgumentError)
    end

    it 'requires product can not be blank' do
      expect { Product.new('') }.to raise_error(ArgumentError)
    end

    it 'price is default to 0' do
      product = Product.new('GR1')
      expect(product.code).to eq 'GR1'
      expect(product.price).to eq 0.00
    end

    it 'fails if price isn\'t 0 or positive value' do
      expect { Product.new('GR1', -1.00) }.to raise_error(ArgumentError)
    end

    it 'price has to be 0 or positive value' do
      product = Product.new('GR1', 1.00)
      expect(product.price).to eq 1.00
    end
  end
end
