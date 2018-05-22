require 'spec_helper'

module Spree
  module Calculator::Shipping
    describe FlatMultiCurrencyRate do
      let!(:currency_rate) { create :currency_rate, currency: 'GBP', exchange_rate: 0.75 }
      let(:order) { build(:order) }
      let(:variant1) { build(:variant) }
      let(:variant2) { build(:variant) }
      let(:inventory_unit1) { build(:inventory_unit, variant: variant1, order: order) }
      let(:inventory_unit2) { build(:inventory_unit, variant: variant2, order: order) }

      subject { Calculator::Shipping::FlatMultiCurrencyRate.new(preferred_amount: 4.00) }

      context 'order for another currency' do
        let(:order) { build(:order, currency: 'GBP') }
        let(:package) do
          Stock::Package.new(
            build(:stock_location),
            [
              Stock::ContentItem.new(inventory_unit1, 2),
              Stock::ContentItem.new(inventory_unit2, 1)
            ]
          )
        end

        it 'always returns the same rate for base currency' do
          expect(subject.compute(package)).to eql 3.00
        end
      end

      context 'order for base currency' do
        let(:package) do
          Stock::Package.new(
            build(:stock_location),
            [
              Stock::ContentItem.new(inventory_unit1, 2),
              Stock::ContentItem.new(inventory_unit2, 1)
            ]
          )
        end

        it 'always returns the same rate for base currency' do
          expect(subject.compute(package)).to eql 4.00
        end
      end

    end
  end
end
