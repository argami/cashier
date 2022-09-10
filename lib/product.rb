# frozen_string_literal: true

class Product
  attr_accessor :code, :price

  def initialize(code, price = 0.00)
    raise ArgumentError, 'product needs a valid code' if code.empty?
    raise ArgumentError, 'price needs to be positive or 0' if price.negative?

    self.code = code
    self.price = price
  end
end
