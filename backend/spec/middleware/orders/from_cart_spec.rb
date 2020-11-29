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
    context 'new order' do
      let(:order) { Order.first }

      before { described_class.create(cart) }

      it { expect(order.total_tax.amount).to eql cart.total_tax.amount }
      it { expect(order.total_discount.amount).to eql cart.total_discount.amount }
      it { expect(order.order_items.size).to eql 3 }
      it { expect(order.total.amount).to eql cart.total.amount }
      it { expect(order.status).to eql 'received' }
    end
  end
end
