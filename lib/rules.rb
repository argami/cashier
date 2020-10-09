# frozen_string_literal: true

class Rules
  def initialize(*rules)
    @rules = []
    rules.each { |rule| add(rule) }
  end

  def count
    @rules.count
  end

  def each
    @rules.each { |p| yield p }
  end

  def add(rule)
    raise StandardError.new('only one rule per product') if self.exists?(rule)
    @rules << rule
  end

  def find(code)
    @rules.find { |rule| rule.code == code }
  end

  private

  def exists?(rule)
    @rules.map(&:code).include?(rule.code)
  end
end
