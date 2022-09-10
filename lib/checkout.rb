# frozen_string_literal: true

class Checkout
  def initialize(rules = [])
    raise Errors::RulesEmptyError if rules.count.zero?

    @rules = rules
    @items = []
    @cart = {}

    # group quantity set to 0
    rules.each { |rule| @cart[rule.code] = 0 }
  end

  def scan(barcode)
    raise Errors::ProductNotFoundError unless @rules.find(barcode)

    @items << barcode
    @cart[barcode] += 1
  end

  def total
    @cart.reduce(0) do |total, (item, quantity)|
      rule = @rules.find(item)
      total + rule.apply(quantity:)
    end.floor(2)
  end
end
