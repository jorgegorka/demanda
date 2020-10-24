# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Address::Delete, type: :request do
  let(:address) { create(:address, :for_user) }
  let(:address_uuid) { address.uuid }
  let(:user) { address.addressable }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteAddress (
          input: {
            id: "#{address_uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete address' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteAddress']
    end

    context 'when address belongs to current account' do
      it { is_expected.to include 'message' => 'Address was deleted' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when address belongs to another account' do
      let(:address2) { create(:address, :for_user) }
      let(:address_uuid) { address2.uuid }

      it { is_expected.to include 'message' => '' }
      it { is_expected.to include 'errors' => ["id: #{address2.uuid}", 'Address not found'] }
    end
  end
end
