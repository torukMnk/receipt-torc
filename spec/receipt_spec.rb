require 'pry'
require_relative '../receipt'

describe '#Receipt 1' do
  subject { Receipt.new(purchases) }
  let(:purchases) { ["2 book at 12.49",
                     "1 music CD at 14.99",
                     "1 chocolate bar at 0.85"]
  }

  context 'Items decorator' do
    it 'must return items and totals' do
      expected_items = ["2 book: 24.98",
                        "1 music CD: 16.49",
                        "1 chocolate bar: 0.85"]
      expect(subject.items_decorator).to eq(expected_items)

    end
  end

  context 'Tax decorator' do
    it 'must return taxes and total' do
      subject.items_decorator
      expect(subject.taxes_decorator).to eq("Sales Taxes: 1.5")
    end
  end

  context 'Total decorator' do
    it 'must return total' do
      subject.items_decorator
      expect(subject.total_decorator).to eq("Total: 42.32")
    end
  end
end

describe '#Receipt 2' do
  subject { Receipt.new(purchases) }
  let(:purchases) { [
    "1 imported box of chocolates at 10.00",
    "1 imported bottle of perfume at 47.50" ]
  }

  context 'Items decorator' do
    it 'must return items and totals' do
      expected_items = ["1 imported box of chocolates: 10.5",
                        "1 imported bottle of perfume: 54.65"]

      expect(subject.items_decorator).to eq(expected_items)
    end
  end

  context 'Tax decorator' do
    it 'must return taxes and total' do
      subject.items_decorator
      expect(subject.taxes_decorator).to eq("Sales Taxes: 7.65")
    end
  end

  context 'Total decorator' do
    it 'must return total' do
      subject.items_decorator
      expect(subject.total_decorator).to eq("Total: 65.15")
    end
  end
end

describe '#Receipt 3' do
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
    end
  end

  context 'Total decorator' do
    it 'must return total' do
      subject.items_decorator
      expect(subject.total_decorator).to eq("Total: 98.38")
    end
  end
end
