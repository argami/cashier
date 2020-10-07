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
      total += @rules[item][:price] * quantity 
    end
  end  
end