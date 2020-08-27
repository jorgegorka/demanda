# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Tax::Create, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        createTax (
          #{input_params}
        ) {
          tax {
            name
            active
            startAt
            amount
          }
          errors
        }
      }
    GQL
  end

  describe 'create_tax' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createTax']
    end

    context 'basic input' do
      let(:name) { 'Kreator' }
      let(:percentage) { 9.12 }
      let(:amount) { 0 }
      let(:start_at) { 2.days.ago.iso8601 }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            percentage: #{percentage}
            amount: #{amount}
            startAt: "#{start_at}"
          }
        PARAMS
      end

      it { expect(subject['tax']).to include 'name' => 'Kreator' }
      it { expect(subject['tax']).to include 'active' => true }
      it { expect(subject['tax']).to include 'amount' => 0 }
      it { expect(subject['tax']).to include 'startAt' => start_at }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
