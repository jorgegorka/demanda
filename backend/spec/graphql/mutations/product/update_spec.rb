# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Product::Update, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:product_uuid) { product.uuid }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Ghost' }
  let(:query) do
    <<~GQL
      mutation {
        updateProduct (
          input: {
            id: "#{product_uuid}"
            name: "#{name}"
          }
        ) {
          product {
            name
            slug
            price
            stock
          }
          errors
        }
      }
    GQL
  end

  describe 'update_product' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateProduct']
    end

    it { expect(subject['product']).to include 'name' => 'Ghost', 'slug' => product.slug }
    it { is_expected.to include 'errors' => [] }

    context 'if product uuid is wrong' do
      let(:product_uuid) { 'wrong' }

      it { expect(subject['product']).to be_nil }
      it { is_expected.to include 'errors' => ['Product not found'] }
    end
  end
end
