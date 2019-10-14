require 'rails_helper'

describe Products::Persistence do
  let(:account) { create(:account) }
  let(:customer) { create(:customer, account: account) }
  let(:category) { create(:category, account: account) }
  let(:product) { create(:product, category: category) }
  let(:name) { 'Vanessa Collier' }
  let(:description) { 'Meeting my shadow' }
  let(:default_params) { { name: name, price: 23.99, stock: 37 } }
  let(:params) { default_params }
  let(:product_persistence) { described_class.new(account) }

  describe '.create' do
    subject { product_persistence.create(params) }

    it { expect { subject }.to change{ Product.count }.by(1) }
    it { expect(subject.name).to eql 'Vanessa Collier' }
    it { expect(subject.price.amount).to eql 23.99 }
    it { expect(subject.stock).to eql 37 }

    context 'when there is a category uuid' do
      let(:params) { default_params.merge(category_id: category.uuid) }

      it { expect(subject.category).to eql category }
    end

    context 'when there is a description' do
      let(:params) { default_params.merge(description: description) }

      it { expect(subject.description).to eql description }
    end
  end

  describe '.update' do
    let(:product) { create(:product, account: account, category: category) }
    let(:default_params) { { id: product.uuid, name: 'Axel Rudi Pell', price: 8.33, stock: 69 } }

    subject { product_persistence.update(params) }

    it { expect(subject.name).to eql 'Axel Rudi Pell' }
    it { expect(subject.price.amount).to eql 8.33 }
    it { expect(subject.stock).to eql 69 }

    context 'when there is a category uuid' do
      let(:params) { default_params.merge(category_id: category.uuid) }

      it { expect(subject.category).to eql category }
    end

    context 'when there is a description' do
      let(:params) { default_params.merge(description: description) }

      it { expect(subject.description).to eql description }
    end
  end
end
