# frozen_string_literal: true

class Rule
  attr_accessor :price, :minimun, :per, :product

  def initialize(product, minimun: 0, per: 1, price: nil)
    self.product = product
    self.minimun = minimun
    self.per = per

    # the price of the rule should be the same of
    # the product in case it wasn't informed
    self.price = price || product.price
  end

  def code
    product.code
  end

  def active?
    minimun.positive?
  end
end
