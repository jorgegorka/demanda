# frozen_string_literal: true

require 'rails_helper'

describe Products::Rating do
  let(:product) { create(:product) }

  describe '#update' do
    context 'when there no approved comments' do
      before { create(:comment, commentable: product, approved: false, account: product.account, rating: 2) }

      it { expect(product.rating).to eql 0 }
    end

    context 'when there are approved comments' do
      before do
        create(:comment, commentable: product, account: product.account, rating: 2)
        create(:comment, commentable: product, account: product.account, rating: 3)
        create(:comment, commentable: product, account: product.account, rating: 5)
        create(:comment, commentable: product, account: product.account, rating: 5, approved: false)
        create(:comment, commentable: product, account: product.account, rating: 5, approved: false)
        create(:comment, commentable: product, account: product.account, rating: 5, approved: false)
      end

      it { expect(product.rating).to eql 66 }
    end
  end
end
