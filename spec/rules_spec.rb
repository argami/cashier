# frozen_string_literal: true

require 'product.rb'
require 'rule.rb'
require 'rules.rb'

RSpec.describe Rules do
  before(:each) do
    product = Product.new 'GR1', 3.11
    @rule = Rule.new product
    product2 = Product.new 'GR2', 3.11
    @rule2 = Rule.new product2
  end

  describe '#new and .add()' do
    it 'can be initialized without arguments' do
      rules = Rules.new
      expect(rules.count).to eq 0
    end

    it 'can be initialized with arguments' do
      rules = Rules.new(@rule)
      expect(rules.count).to eq 1
    end

    it 'fails adding same rule twice' do
      expect { Rules.new(@rule, @rule) }.to raise_error(StandardError)
    end

    it 'accepts 2 rules' do
      rules = Rules.new(@rule, @rule2)
      expect(rules.count).to eq 2
    end
  end

  describe '#find' do 
    before(:each) do
      @rules = Rules.new
      @rules.add(@rule)
      @rules.add(@rule2)
    end

    it 'finds the rule by code and returns the rule' do
      expect(@rules.find('GR2').code).to eq 'GR2'
    end

    it 'returns nil when rule is not founded' do
      expect(@rules.find('GR3')).to eq nil
    end
  end
end
