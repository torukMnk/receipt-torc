class PurchaseItemBuilder
  include Taxes

  def initialize(purchase)
    @purchase = purchase
  end

  def data
    item = item_builder
    taxes = tax_builder(item)
    adjustments = taxes_adjustments(taxes, item)

    {
      quantity: item[:quantity],
      label: item[:label],
      label: label_decorator(item),
      price: item[:price],
      imported: item[:imported],
      taxes: taxes,
      subtotal: item[:subtotal],
      total_taxes: adjustments,
      total: (item[:subtotal] + adjustments).round(2)
    }
  end

  def label_decorator(item)
    return "imported " << item[:label] if item[:imported]

    item[:label]
  end

  def taxes_adjustments(taxes, item)
    total = []
    good_tax = taxes.find { |t| t[:type] == "GOOD" }
    import_tax = taxes.find { |t| t[:type] == "IMPORTS" }

    total << item[:quantity] * good_tax[:tax] if good_tax
    total << item[:quantity] * import_tax[:tax] if import_tax

    total.sum.round(2)
  end

  def item_builder
    parser = {}
    line_item = @purchase.split
    parser[:quantity] = line_item.first.to_i
    parser[:label] = label_parse(line_item)
    parser[:price] = line_item.last.to_f
    parser[:imported] = line_item.include?('imported')
    parser[:subtotal] = parser[:quantity] * parser[:price]

    parser
  end

  def label_parse(item)
    return item[2..-3].join(" ") if item.include?('imported')

    item[1..-3].join(" ")
  end

  def tax_builder(item)
    taxes = []
    tax_good = !GOODS_EXCEPTIONS.include?(item[:label])
    tax_import = item[:imported]

    taxes << { type: 'GOOD', tax: (item[:price] * GOODS_TAX).round(2) } if tax_good
    taxes << { type: 'IMPORTS', tax: (item[:price].to_f * IMPORT_TAX).round(1) } if tax_import

    taxes
  end
end
