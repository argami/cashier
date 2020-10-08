# frozen_string_literal: true

class Checkout
  def initialize(rules = [])
    raise Errors::RulesEmptyError if rules.empty?

    @rules = rules
    @items = []
    @cart = {}

    # group quantity set to 0
    rules.each { |rule| @cart[rule.code] = 0 }
  end

  def scan(barcode)
    raise Errors::ProductNotFoundError unless @rules.map(&:code).include?(barcode)

    @items << barcode
    @cart[barcode] += 1
  end

  def total
    @cart.reduce(0) do |total, (item, quantity)|
      rule = @rules.find { |r| r.code == item }
      if rule.active? && quantity >= rule.minimun
        total += rule.price * (quantity / rule.per).floor
        quantity = quantity % rule.per
      end
      total + rule.product.price * quantity
    end.floor(2)
  end
end
