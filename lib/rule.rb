# frozen_string_literal: true

class Rule
  attr_accessor :price, :minimun, :per, :product

  def initialize(product, minimun: 0, per: 1, price: nil)
    # the price of the rule should be the same of
    # the product in case it wasn't informed
    self.price = price || product.price
    raise ArgumentError.new('price should be a positive number') if self.price.negative?
    
    self.product = product
    self.minimun = minimun
    self.per = per
  end

  def code
    product.code
  end

  def active?
    minimun.positive?
  end

  def apply(quantity: 0)
    total = 0

    if active? && quantity >= minimun
      total += price * (quantity / per).floor
      quantity = quantity % per
    end

    total + product.price * quantity
  end
end
