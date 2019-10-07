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

  it { should define_enum_for(:status).with(%i[card confirmed delivered received rejected cancelled]) }

  describe '.update_price' do
    let(:account) { create(:account) }
    let(:customer) { create(:customer, account: account) }
    let(:order) { create(:order, customer: customer) }
    let(:order_item) { create(:order_item, order: order, price: 2, quantity: 2) }
    let(:order_item2) { create(:order_item, order: order, price: 4, quantity: 3) }


    context 'when there are no modifiers' do
      before do
        order_item
        order_item2
        order.update_price
      end

      it { expect(order.gross_price.to_f).to eql 16.0 }
      it { expect(order.total_tax.to_f).to eql 0.00 }
      it { expect(order.total_discount.to_f).to eql 0.00 }
    end

    context 'when there are tax modifiers' do
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0) }

      before do
        order_item
        order_item2
        order.update_price
      end

      it { expect(order.gross_price.to_i).to eql 16 }
      it { expect(order.total_tax.to_f).to eql 1.6 }
      it { expect(order.total_discount.to_f).to eql 0.00 }
    end

    context 'when there are discount modifiers' do
      let!(:discount) { create(:discount, account: account, amount: 33, percentage: 0, customer: customer) }

      before do
        discount
        order_item
        order_item2
        order.update_price
      end

      it { expect(order.gross_price.to_i).to eql 16 }
      it { expect(order.total_tax.to_f).to eql 0.00 }
      it { expect(order.total_discount.to_f).to eql 33.00 }
    end
  end
end
