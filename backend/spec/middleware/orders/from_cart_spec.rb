# frozen_string_literal: true

require 'rails_helper'

describe Orders::FromCart do
  let(:user) { create(:user) }
  let!(:tax) { create(:tax, percentage: 21, name: '21% VAT', account: user.account) }
  let!(:cart) { create(:cart, user: user, account: user.account) }
  let!(:item_qty2) { create(:cart_item, cart: cart, quantity: 2) }
  let!(:item_qty1) { create(:cart_item, cart: cart, quantity: 1) }
  let!(:item_qty3) { create(:cart_item, cart: cart, quantity: 3) }
  let(:payment_type) { :credit_card }
  let(:amount) { cart.total }

  describe '.create' do
    before { described_class.create(cart, payment_type, amount) }

    context 'created order' do
      subject { Order.first }

      it { expect(subject.total_tax.amount).to eql cart.total_tax.amount }
      it { expect(subject.total_discount.amount).to eql cart.total_discount.amount }
      it { expect(subject.order_items.count).to eql 3 }
      it { expect(subject.total.amount).to eql cart.total.amount }
      it { expect(subject.status).to eql 'approved' }
      it { expect(OrderLog.count).to eql 2 }

      context 'when payment is less than total' do
        let(:amount) { 1 }

        it { expect(subject.status).to eql 'received' }
        it { expect(OrderLog.count).to eql 1 }
      end
    end

    context 'payment' do
      let(:payment_type) { 'credit_card' }
      let(:amount) { 187.35 }
      let(:order) { user.orders.first }

      subject { order.payments.first }

      it { expect(subject.origin).to eql payment_type }
      it { expect(subject.total.amount).to eql 187.35 }
    end
  end
end
