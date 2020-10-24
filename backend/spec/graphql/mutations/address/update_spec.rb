# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Address::Update, type: :request do
  let(:address) { create(:address, :for_user) }
  let(:user) { address.addressable }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        updateAddress (
          input: {
            id: "#{address.uuid}"
            firstAddress: "They Rode On"
            name: "The Wild Hunt"
            city: "Watain"
          }
        ) {
          address {
            firstAddress
            name
            city
          }
          errors
        }
      }
    GQL
  end

  describe 'update_address' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateAddress']['address']
    end

    it { is_expected.to include 'firstAddress' => 'They Rode On' }
    it { is_expected.to include 'name' => 'The Wild Hunt' }
    it { is_expected.to include 'city' => 'Watain' }
  end
end
