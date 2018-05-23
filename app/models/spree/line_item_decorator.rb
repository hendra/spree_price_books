Spree::LineItem.class_eval do
  after_initialize :process_deferred_update_price_from_modifier if :update_price_from_modifier_deferred?

  def options=(options = {})
    @options = options
    @update_price_from_modifier_deferred = false
    return unless @options.present?

    currency = @options[:currency] || order.try(:currency)

    if order
      update_price_from_modifier(currency, @options)
    else
      # If this method is called from the object constructor, the order has not been initialized yet.
      # We can't find the proper price until the order initialized.
      @update_price_from_modifier_deferred = true
    end

    assign_attributes @options
  end

  def update_price
    role_ids = order.user.try(:price_book_role_ids)
    price_book_price = variant.price_in(order.currency, order.store, role_ids)

    self.price = price_book_price.price_including_vat_for(tax_zone: tax_zone)
  end

  private
    def update_price_from_modifier_deferred?
      !!@update_price_from_modifier_deferred
    end

    def process_deferred_update_price_from_modifier
      return unless @options.present? && price.nil?

      currency = @options[:currency] || order.try(:currency)

      update_price_from_modifier(currency, @options)
    end

    def update_price_from_modifier(currency, opts)
      role_ids = order.try(:user).try(:price_book_role_ids)
      if currency
        self.currency = currency
        self.price = variant.price_in(currency, order.try(:store_id), role_ids).amount +
          variant.price_modifier_amount_in(currency, opts)
      else
        self.price = variant.price_in(currency, order.try(:store_id), role_ids).amount +
          variant.price_modifier_amount(opts)
      end
    end
end
