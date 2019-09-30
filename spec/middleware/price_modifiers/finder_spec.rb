require 'rails_helper'

describe PriceModifiers::Finder do
  let(:account) { create(:account) }
  let(:category) { create(:category, account: account) }
  let(:product) { create(:product, account: account, category: category) }
  let(:order) { create(:order, account: account) }
  let(:customer) { order.customer }
  let(:start_at) { 3.weeks.ago }
  let(:end_at) {}


  describe '.for_order' do
    subject { described_class.for_order(order) }

    it { is_expected.to be_empty }

    context 'a generic tax' do
      let!(:tax) { create(:tax, start_at: start_at, end_at: end_at, account: account) }

      context 'when there are modifiers but dates not in range' do
        let(:end_at) { 1.week.ago }

        it { is_expected.to be_empty }
      end

      context 'when there is a global modifier available' do
        it { is_expected.to include tax }
      end
    end

    context 'discount for customers' do
      let!(:discount) { create(:discount_for_customer, account: account, customer: customer) }

      it { is_expected.to include discount }

      context 'when there is a modifier available for another customer' do
        let(:customer) { create(:customer, account: account) }

        it { is_expected.to be_empty }
      end
    end
  end

  describe '.for_products' do
    let(:order_item) { create(:order_item, order: order, product: product) }

    subject { described_class.for_product(order_item) }

    context 'when there are no modifiers available' do
      it { is_expected.to be_empty }
    end

    context 'a generic tax' do
      let!(:tax) { create(:tax, start_at: start_at, end_at: end_at, account: account, product: order_item.product) }

      context 'when there are modifiers but dates not in range' do
        let(:end_at) { 1.week.ago }

        it { is_expected.to be_empty }
      end

      context 'when there is a global modifier available' do
        it { is_expected.to include tax }
      end
    end

    context 'discount for customers' do
      let!(:discount) { create(:discount_for_customer, customer: customer, account: account, category: product.category) }

      it { is_expected.to include discount }

      context 'when there is a modifier available for another customer' do
        let(:customer) { create(:customer, account: account) }

        it { is_expected.to be_empty }
      end
    end
  end
end
