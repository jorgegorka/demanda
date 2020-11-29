require 'rails_helper'

RSpec.describe Order, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'directionable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :coupon }

  it { is_expected.to have_many :order_items }
  it { is_expected.to have_many :order_price_modifiers }

  it { is_expected.to monetize(:total_tax) }
  it { is_expected.to monetize(:total_discount) }

  it { should define_enum_for(:status).with(%i[received approved on_route delivered rejected cancelled]) }

  describe '.add_modifiers' do
    let(:account) { create(:account) }
    let(:user) { create(:user, account: account) }
    let(:order) { create(:order, user: user) }
    let!(:order_item) { create(:order_item, order: order, price: 2, quantity: 2) }
    let!(:order_item2) { create(:order_item, order: order, price: 4, quantity: 3) }

    context 'when there are no modifiers' do
      before { order.add_modifiers }

      it { expect(order.total_gross.amount).to eql 16.0 }
      it { expect(order.total_tax.amount).to eql 0.00 }
      it { expect(order.total_discount.amount).to eql 0.00 }
      it { expect(order.total_net.amount).to eql 16.00 }
      it { expect(order.total.amount).to eql 16.00 }
    end

    context 'when there are both a tax and a discount' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, user: user) }
      let!(:discount2) { create(:discount, account: account, amount: 0, percentage: 5) }
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0) }

      before { order.add_modifiers }

      it { expect(order.total_gross.amount).to eql 16.0 }
      it { expect(order.total_tax.amount).to eql 1.24 }
      it { expect(order.total_discount.amount).to eql 3.65 }
      it { expect(order.total_net.amount).to eql 12.35 }
      it { expect(order.total.amount).to eql 13.59 }
    end

    context 'when there are tax modifiers' do
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0) }

      before { order.add_modifiers }

      it { expect(order.total_gross.amount).to eql 16.0 }
      it { expect(order.total_tax.amount).to eql 1.6 }
      it { expect(order.total_discount.amount).to eql 0.00 }
      it { expect(order.total_net.amount).to eql 16.00 }
      it { expect(order.total.amount).to eql 17.60 }
    end

    context 'when there is a discount modifiers with amount' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, user: user) }

      before { order.add_modifiers }

      it { expect(order.total_gross.amount).to eql 16.0 }
      it { expect(order.total_tax.amount).to eql 0.00 }
      it { expect(order.total_discount.amount).to eql 3.00 }
      it { expect(order.total_net.amount).to eql 13.00 }
      it { expect(order.total.amount).to eql 13.00 }
    end

    context 'when there is a discount with a minimum price' do
      let!(:discount) { create(:discount, account: account, amount: 0, percentage: 5, user: user, minimum_price: 100) }

      context 'when minimum is not reached' do
        before { order.add_modifiers }

        it { expect(order.total_gross.amount).to eql 16.0 }
        it { expect(order.total_tax.amount).to eql 0.00 }
        it { expect(order.total_discount.amount).to eql 0.00 }
        it { expect(order.total_net.amount).to eql 16.00 }
        it { expect(order.total.amount).to eql 16.00 }
      end

      context 'when minimum is been reached' do
        let!(:order_item3) { create(:order_item, order: order, price: 5, quantity: 20) }

        before { order.add_modifiers }

        it { expect(order.total_gross.amount).to eql 116.0 }
        it { expect(order.total_tax.amount).to eql 0.00 }
        it { expect(order.total_discount.amount).to eql 5.8 }
        it { expect(order.total_net.amount).to eql 110.2 }
        it { expect(order.total.amount).to eql 110.2 }
      end
    end
  end
end
