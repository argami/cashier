# frozen_string_literal: true

module Errors
  class ProductNotFoundError < StandardError; end
  class RulesEmptyError < StandardError; end
  class ProductPriceError < StandardError; end
end
