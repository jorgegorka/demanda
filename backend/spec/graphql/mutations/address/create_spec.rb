# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Address::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        name
        firstAddress
        secondAddress
        city
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createAddress (
          #{input_params}
        ) {
          address #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create address' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createAddress']
    end

    context 'basic input' do
      let(:first_address) { 'Summoning' }
      let(:second_address) { 'Old mornings down' }
      let(:city) { 'Caradhras' }
      let(:postal_code) { 77_552 }
      let(:input_params) do
        <<~PARAMS
          input: {
            firstAddress: "#{first_address}"
            secondAddress: "#{second_address}"
            postalCode: "#{postal_code}"
            city: "#{city}"
            country: "ESP"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('address' => a_hash_including('firstAddress' => first_address))) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
