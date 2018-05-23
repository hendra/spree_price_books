require 'spec_helper'

describe Spree::OrderContents do
  describe '#add' do
    context "with separate price books for stores" do
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
      let(:variant) { create :variant }
      let!(:price_1) { create :price, variant_id: variant.id, price_book_id: price_book_1.id, amount: 10.01 }
      let!(:price_2) { create :price, variant_id: variant.id, price_book_id: price_book_2.id, amount: 20.02 }
      let(:order_1) { create :order, store_id: store_1.id }
      let(:order_2) { create :order, store_id: store_2.id }

      it "should set line item price to the proper variant price" do
        line_item_1 = Spree::OrderContents.new(order_1).add variant
        line_item_2 = Spree::OrderContents.new(order_2).add variant

        expect(line_item_1.price).to eq price_1.amount
        expect(line_item_2.price).to eq price_2.amount
      end
    end
  end
end
