# frozen_string_literal: true

require 'product.rb'

RSpec.describe Product do
  describe '#new' do
    it 'requires product code' do
      expect { Product.new }.to raise_error(ArgumentError)
    end

    it 'price is default to 0' do
      product = Product.new('GR1')
      expect(product.code).to eq 'GR1'
      expect(product.price).to eq 0.00
    end
  end
end
