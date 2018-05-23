require 'spec_helper'

describe Spree::LineItem do
  let(:order) { create :order }
  let(:variant) { create :variant }

  context "with separate price books for stores" do
    describe '#update_price' do
      let(:price_book_1) {create :price_book}
      let(:price_book_2) {create :price_book}
      let(:store_1) do
        store = create :store
        store.price_books << price_book_1
        store
      end
      let(:store_2) do
        store = create :store
        store.price_books << price_book_2
        store
      end
      let!(:price_1) { create :price, variant_id: variant.id, price_book_id: price_book_1.id, amount: 10.01 }
      let!(:price_2) { create :price, variant_id: variant.id, price_book_id: price_book_2.id, amount: 20.02 }
      let(:order_1) { create :order, store_id: store_1.id }
      let(:order_2) { create :order, store_id: store_2.id }

      it "should update line item price to the proper variant price" do
        line_item_1 = order_1.contents.add variant
        line_item_2 = order_2.contents.add variant

        line_item_1.price = 0.1
        line_item_2.price = 0.2

        line_item_1.update_price
        line_item_2.update_price

        expect(line_item_1.price).to eq price_1.amount
        expect(line_item_2.price).to eq price_2.amount
      end
    end
  end

  describe '#options=' do
    it 'should not call deferred price initialization' do
      item = Spree::LineItem.new(quantity: 1, variant: variant)

      expect_any_instance_of(Spree::LineItem).not_to receive(:process_deferred_update_price_from_modifier)

      item.options = {currency: 'USD'}
    end

    context 'implicitly called from the constructor' do
      it 'should call deferred price initialization' do
        expect_any_instance_of(Spree::LineItem).to receive(:process_deferred_update_price_from_modifier)

        Spree::LineItem.new(quantity: 1, variant: variant, options: {currency: 'USD'})
      end

      it 'should initialize price' do
        item = Spree::LineItem.new(quantity: 1, variant: variant, options: {currency: 'USD'})

        expect(item.price).to eql variant.price
      end

      it 'should set price from options' do
        item = Spree::LineItem.new(quantity: 1, variant: variant, options: {currency: 'USD', price: 333.01})

        expect(item.price).to eql 333.01
      end
    end
  end
end
