# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'localisable'
  it_behaves_like 'attachable'
  it_behaves_like 'commentable'
  it_behaves_like 'slugable'
  it_behaves_like 'meta_taggable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to(:category).optional }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:account_id).case_insensitive }

  it { is_expected.to monetize(:price) }

  describe '#tags_for_query' do
    let(:product) { create(:product) }

    subject { product.tags_for_query }

    it { is_expected.to eql product.tag_names.join(', ') }
  end

  describe '#related' do
    let(:account) { create(:account) }
    let(:product) { create(:product, account: account) }

    before { 6.times { create(:product, account: account) } }

    context 'when there are none it returns 3 random products' do
      it { expect(product.related.size).to eql 3 }
    end

    context 'when there are related products' do
      let(:other_products) { Product.where.not(id: product.id).limit(3).pluck(:id).join(',') }

      before do
        product.related_products = other_products
        product.save
      end

      it { expect(product.related.size).to eql 3 }
      it { expect(product.related.all.pluck(:id)).to include(*other_products.split(',').map(&:to_i)) }
    end
  end

  describe 'default content' do
    let(:product) { create(:product) }

    context 'when there is a default language' do
      before { create(:language, code: I18n.default_locale) }
      it { expect(product.translations.size).to eql 4 }
    end

    context 'when there is no default language' do
      it { expect(product.translations.size).to eql 0 }
    end
  end
end
