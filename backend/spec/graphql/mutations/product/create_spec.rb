# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Product::Create, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        createProduct (
          #{input_params}
        ) {
          product {
            name
            price
            stock
            tags
          }
          errors
        }
      }
    GQL
  end

  describe 'create_product' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createProduct']
    end

    context 'basic input' do
      let(:name) { 'Soilwork' }
      let(:price) { 9.12 }
      let(:stock) { 100 }
      let(:tags) { 'metal, heavy metal, melodic death metal' }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            price: #{price}
            stock: #{stock}
            tags: "#{tags}"
          }
        PARAMS
      end

      it { expect(subject['product']).to include 'name' => 'Soilwork' }
      it { expect(subject['product']).to include 'price' => 9.12 }
      it { expect(subject['product']).to include 'stock' => 100 }
      it { expect(subject['product']).to include 'tags' => 'metal, heavy metal, melodic death metal' }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
