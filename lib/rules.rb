# frozen_string_literal: true

class Rules
  attr_reader :rules

  def initialize(*received_rules)
    @rules = []
    received_rules.each { |rule| add(rule) }
  end

  def count
    rules.count
  end

  def each(&)
    rules.each(&)
  end

  def add(rule)
    raise StandardError, 'only one rule per product' if exists?(rule)

    rules << rule
  end

  def find(code)
    rules.find { |rule| rule.code == code }
  end

  private

  def exists?(rule)
    rules.map(&:code).include?(rule.code)
  end
end
