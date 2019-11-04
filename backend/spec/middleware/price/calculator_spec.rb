require 'rails_helper'

describe Price::Calculator do
  let(:account) { create(:account) }
  let(:customer) { create(:customer, account: account) }
  let(:category) { create(:category, account: account) }
  let(:order) { create(:order, account: account, customer: customer) }
  let(:product) { create(:product, category: category) }
  let(:percentage) { 10 }
  let(:amount) { 0 }
  let(:quantity) { 5 }
  let(:total_gross) { 50 * quantity }
  let(:price_calculator) { described_class.new(price_modifier, total_gross) }

  describe '#calculate' do
    before { price_calculator.calculate }

    context 'when modifier is a tax' do
      let!(:price_modifier) { create(:tax, account: account, percentage: percentage, amount: amount, product: product) }

      context 'when is a percentage' do
        it { expect(price_calculator.total_tax.amount).to eql 25 }
        it { expect(price_calculator.total_discount.amount).to eql 0 }
      end

      context 'when is a fixed amount' do
        let(:percentage) { 0 }
        let(:amount) { 150 }

        it { expect(price_calculator.total_tax.amount).to eql 150.00 }
        it { expect(price_calculator.total_discount.amount).to eql 0 }
      end
    end

    context 'when modifier is a discount' do
      let!(:price_modifier) { create(:discount, account: account, percentage: percentage, amount: amount, product: product) }

      context 'when is a percentage' do
        it { expect(price_calculator.total_tax.amount).to eql 0 }
        it { expect(price_calculator.total_discount.amount).to eql 25 }
      end

      context 'when is a fixed amount' do
        let(:percentage) { 0 }
        let(:amount) { 150 }

        it { expect(price_calculator.total_tax.amount).to eql 0 }
        it { expect(price_calculator.total_discount.amount).to eql 150.00 }
      end
    end
  end
end
