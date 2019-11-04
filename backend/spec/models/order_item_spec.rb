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

  describe '#update_total' do
    let(:account) { create(:account) }
    let(:customer) { create(:customer, account: account) }
    let(:category) { create(:category, account: account) }
    let(:product) { create(:product, category: category) }
    let(:discount) { create(:discount, account: account, amount: 33, percentage: 0, product: product) }
    let(:order) { create(:order, customer: customer) }
    let(:order_item) { create(:order_item, order: order, product: product, price: 2, quantity: 2) }

    context 'when there are no modifiers' do
      it { expect(order_item.total_tax.to_f).to eql 0.00 }
      it { expect(order_item.total_discount.to_f).to eql 0.00 }
      it { expect(order_item.total_gross.to_f).to eql 4.00 }
      it { expect(order_item.total_net.to_f).to eql 4.00 }
      it { expect(order_item.total.to_f).to eql 4.00 }
    end

    context 'when there are tax modifiers' do
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0, category: category) }

      it { expect(order_item.total_gross.to_i).to eql 4 }
      it { expect(order_item.total_tax.to_f).to eql 0.40 }
      it { expect(order_item.total_discount.to_f).to eql 0.00 }
      it { expect(order_item.total_net.to_f).to eql 4.00 }
      it { expect(order_item.total.to_f).to eql 4.40 }
    end

    context 'when there are discount modifiers' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, product: product) }

      it { expect(order_item.total_gross.to_i).to eql 4 }
      it { expect(order_item.total_tax.to_f).to eql 0.00 }
      it { expect(order_item.total_discount.to_f).to eql 3.00 }
      it { expect(order_item.total_net.to_f).to eql 1.00 }
      it { expect(order_item.total.to_f).to eql 1.0 }
    end

    context 'when there are both modifiers' do
      let!(:discount) { create(:discount, account: account, amount: 3, percentage: 0, product: product) }
      let!(:tax) { create(:tax, account: account, percentage: 10, amount: 0, category: category) }

      it { expect(order_item.total_gross.to_i).to eql 4 }
      it { expect(order_item.total_tax.to_f).to eql 0.10 }
      it { expect(order_item.total_discount.to_f).to eql 3.00 }
      it { expect(order_item.total_net.to_f).to eql 1.00 }
      it { expect(order_item.total.to_f).to eql 1.1 }
    end
  end
end
