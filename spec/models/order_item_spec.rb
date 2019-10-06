require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :product }

  it { is_expected.to have_many :order_price_modifiers }

  it { is_expected.to monetize(:price) }
  it { is_expected.to monetize(:quantity) }
  it { is_expected.to monetize(:total_tax) }
  it { is_expected.to monetize(:total_discount) }

  describe '#update_price' do
    let(:account) { create(:account) }
    let(:customer) { create(:customer, account: account) }
    let(:category) { create(:category, account: account) }
    let(:product) { create(:product, category: category) }
    let(:tax) { create(:tax, account: account, percentage: 10, amount: 0, category: category) }
    let(:discount) { create(:discount, account: account, amount: 33, percentage: 0, product: product) }
    let(:order) { create(:order, customer: customer) }
    let(:order_item) { create(:order_item, order: order, product: product, price: 2, quantity: 2) }


    context 'when there are no modifiers' do
      before { order_item.update_price }

      it { expect(order_item.total_tax.to_f).to eql 0.00 }
      it { expect(order_item.total_discount.to_f).to eql 0.00 }
    end

    context 'when there are tax modifiers' do
      before do
        tax
        order_item.update_price
      end

      it { expect(order_item.gross_price.to_i).to eql 4 }
      it { expect(order_item.total_tax.to_f).to eql 0.40 }
      it { expect(order_item.total_discount.to_f).to eql 0.00 }
    end

    context 'when there are discount modifiers' do


      before do
        discount
        order_item.update_price
      end

      it { expect(order_item.gross_price.to_i).to eql 4 }
      it { expect(order_item.total_tax.to_f).to eql 0.00 }
      it { expect(order_item.total_discount.to_f).to eql 33.00 }
    end
  end
end
