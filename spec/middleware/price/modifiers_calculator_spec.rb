require 'rails_helper'

describe Price::ModifiersCalculator do
  let(:account) { create(:account) }
  let(:order) { create(:order, account: account) }
  let(:product) { create(:product, account: account) }
  let(:percentage) { 10 }
  let(:amount) { 0 }
  let(:order_item) { create(:order_item, order: order, product: product, price: 50, quantity: 5) }
  let(:order_price_modifier) { order_item.order_price_modifiers.find_by(price_modifier_id: tax.id) }
  let(:price_calculator) { described_class.new(order_price_modifier) }

  describe '#update_price' do
    context 'when modifier is a tax' do
      let!(:tax) { create(:tax, account: account, percentage: percentage, amount: amount, product: product) }

      before { price_calculator.update_price }

      context 'when is a percentage' do
        it { expect(order_item.total_tax.amount).to eql 25 }
        it { expect(order_item.total_discount.amount).to eql 0 }
      end

      context 'when is a fixed amount' do
        let(:percentage) { 0 }
        let(:amount) { 150 }

        it { expect(order_item.total_tax.amount).to eql 150.00 }
        it { expect(order_item.total_discount.amount).to eql 0 }
      end
    end
  end
end
