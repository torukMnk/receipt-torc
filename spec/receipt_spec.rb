require 'pry'
require_relative '../receipt'
describe '#Receipt' do
  subject { Receipt.new(purchases) }
  let(:purchases) { ["1 imported bottle of perfume at 27.99",
                     "1 bottle of perfume at 18.99",
                     "1 packet of headache pills at 9.75",
                     "3 imported boxes of chocolates at 11.25" ]
  }

  context 'Items decorator' do

    it 'must return items and totals' do
      expected_items = ["1 imported bottle of perfume: 32.19",
                        "1 bottle of perfume: 20.89",
                        "1 packet of headache pills: 9.75",
                        "3 imported boxes of chocolates: 35.55"]


      expect(subject.items_decorator).to eq(expected_items)
    end
  end

  context 'Tax decorator' do
    it 'must return taxes and total' do
      subject.items_decorator
      expect(subject.taxes_decorator).to eq("Sales Taxes: 7.9")
      expect(subject.total_decorator).to eq("Total: 98.38")
    end
  end
end
