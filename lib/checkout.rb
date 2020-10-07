# frozen_string_literal: true

class Checkout
  def initialize(rules = [])
    @rules = rules
    @items = []
    @cart = {}

    # group quantity set to 0
    rules.each { |rule| @cart[rule[0]] = 0 }
  end

  def scan(barcode)
    @items << barcode
    @cart[barcode] += 1
  end

  def total
    @cart.reduce(0) do |total, (item, quantity)|
      rule = @rules[item][:rule]
      if rule[:min_quantity].positive? && quantity >= rule[:min_quantity]
        total += rule[:price] * (quantity / rule[:price_per]).floor
        quantity = quantity % rule[:price_per]
      end
      total + @rules[item][:price] * quantity
    end
  end
end
