require "checkout.rb"

RSpec.describe Checkout do 
    describe "simple transaction" do
        context "without pricing_rules" do
            it "returns total of £3.11" do
                co = Checkout.new([])
                co.scan("GR1")
                expect(co.total).to eq 3.11
            end
        end
    end
end