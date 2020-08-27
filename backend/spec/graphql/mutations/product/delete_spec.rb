# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Product::Delete, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let!(:product) { create(:product, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteProduct (
          input: {
            id: "#{product.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_product' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteProduct']
    end

    it { is_expected.to include 'message' => 'Product was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
