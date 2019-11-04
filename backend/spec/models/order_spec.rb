require 'rails_helper'

RSpec.describe Order, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'directionable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to :customer }
  it { is_expected.to belong_to :coupon }

  it { is_expected.to have_many :order_items }
  it { is_expected.to have_many :order_price_modifiers }

  it { is_expected.to monetize(:total_tax) }
  it { is_expected.to monetize(:total_discount) }

  it { should define_enum_for(:status).with(%i[confirmed delivered received rejected cancelled]) }

  describe '.add_modifiers' do
    let(:account) { create(:account) }
    let(:customer) { create(:customer, account: account) }
    let(:order) { create(:order, customer: customer) }
    let!(:order_item) { create(:order_item, order: order, price: 2, quantity: 2) }
    let!(:order_item2) { create(:order_item, order: order, price: 4, quantity: 3) }


    context 'when there are no modifiers' do
      before { order.add_modifiers }

      it { expect(order.gross_total.to_f).to eql 16.0 }
      it { expect(order.total_tax.to_f).to eql 0.00 }
      it { expect(order.total_discount.to_f).to eql 0.00 }
      it { expect(order.net_total.to_f).to eql 16.00 }
      it { expect(order.total.to_f).to eql 16.00 }
    end

    context 'when there are both a tax and a discount' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, customer: customer) }
      let!(:discount2) { create(:discount, account: account, amount: 0, percentage: 5) }
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0) }

      before { order.add_modifiers }

      it { expect(order.gross_total.to_i).to eql 16 }
      it { expect(order.total_tax.to_f).to eql 1.24 }
      it { expect(order.total_discount.to_f).to eql 3.65 }
      it { expect(order.net_total.to_f).to eql 12.35 }
      it { expect(order.total.to_f).to eql 13.59 }
    end

    context 'when there are tax modifiers' do
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0) }

      before { order.add_modifiers }

      it { expect(order.gross_total.to_i).to eql 16 }
      it { expect(order.total_tax.to_f).to eql 1.6 }
      it { expect(order.total_discount.to_f).to eql 0.00 }
      it { expect(order.net_total.to_f).to eql 16.00 }
      it { expect(order.total.to_f).to eql 17.60 }
    end

    context 'when there is a discount modifiers with amount' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, customer: customer) }

      before { order.add_modifiers }

      it { expect(order.gross_total.to_i).to eql 16 }
      it { expect(order.total_tax.to_f).to eql 0.00 }
      it { expect(order.total_discount.to_f).to eql 3.00 }
      it { expect(order.net_total.to_f).to eql 13.00 }
      it { expect(order.total.to_f).to eql 13.00 }
    end

    context 'when there is a discount with a minimum price' do
      let!(:discount) { create(:discount, account: account, amount: 0, percentage: 5, customer: customer, minimum_price: 100) }

      context 'when minimum is not reached' do
        before { order.add_modifiers }

        it { expect(order.gross_total.to_i).to eql 16 }
        it { expect(order.total_tax.to_f).to eql 0.00 }
        it { expect(order.total_discount.to_f).to eql 0.00 }
        it { expect(order.net_total.to_f).to eql 16.00 }
        it { expect(order.total.to_f).to eql 16.00 }
      end

      context 'when minimum is been reached' do
        let!(:order_item3) { create(:order_item, order: order, price: 5, quantity: 20) }

        before { order.add_modifiers }

        it { expect(order.gross_total.to_i).to eql 116 }
        it { expect(order.total_tax.to_f).to eql 0.00 }
        it { expect(order.total_discount.to_f).to eql 5.8 }
        it { expect(order.net_total.to_f).to eql 110.2 }
        it { expect(order.total.to_f).to eql 110.2 }
      end
    end
  end
end
