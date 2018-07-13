class Spree::StorePriceBook < ApplicationRecord

  belongs_to :price_book
  belongs_to :store

  delegate :name, to: :price_book

end
