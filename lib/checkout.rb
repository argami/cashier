# frozen_string_literal: true

class Checkout
  def initialize(rules = {})
    @rules = validate_rules(rules)
    @items = []
    @cart = {}

    # group quantity set to 0
    rules.each { |rule| @cart[rule[0]] = 0 }
  end

  def scan(barcode)
    raise Errors::ProductNotFoundError unless @rules.keys.include?(barcode)

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
    end.floor(2)
  end

  private

  def validate_rules(rules)
    raise Errors::RulesEmptyError if rules.empty?

    rules.each do |_, value|
      value[:rule] =  { min_quantity: 0,
                        price_per: 1,
                        price: 0 }.merge(Hash(value[:rule]))
    end

    invalid_product = rules.reduce(true) do |res, product|
      (res && (!product[1][:price].nil? && product[1][:price].positive?))
    end

    raise Errors::ProductPriceError unless invalid_product

    rules
  end
end
