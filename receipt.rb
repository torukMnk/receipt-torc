require 'pry'
require_relative './taxes'
require_relative './purchase_item_builder'

class Receipt
  def initialize(purchases)
    @purchases = purchases
    @total_tax = []
    @item_total = []
  end

  def items_decorator
    items = []
    @purchases.each do |input|
      purchase = PurchaseItemBuilder.new(input)
      @total_tax << purchase.data[:total_taxes]
      quantity = purchase.data[:quantity]
      label = purchase.data[:label]
      subtotal = purchase.data[:total]
      @item_total << subtotal
      items << "#{quantity} #{label}: #{subtotal}"
    end
    items
  end

  def taxes_decorator
    taxes = @total_tax.flatten.sum.round(2)
    "Sales Taxes: #{taxes}"
  end

  def total_decorator
    total = @item_total.sum.round(2)
    "Total: #{total}"
  end

  def show
    items_decorator.each do |item|
      puts item
    end

    puts taxes_decorator
    puts total_decorator
  end
end
