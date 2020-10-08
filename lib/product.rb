# frozen_string_literal: true

class Product
  attr_accessor :code, :price

  def initialize(code, price = 0.00)
    self.code = code
    self.price = price
  end
end
