# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Coupon::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        createCoupon (
          #{input_params}
        ) {
          coupon {
            name
            active
            startAt
            amount
            code
            singleUse
          }
          errors
        }
      }
    GQL
  end

  describe 'create_coupon' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createCoupon']
    end

    context 'basic input' do
      let(:name) { 'White Lion' }
      let(:percentage) { 9.12 }
      let(:amount) { 0 }
      let(:start_at) { 2.days.ago.iso8601 }
      let(:single_use) { true }
      let(:code) { 'BROKENHEART' }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            percentage: #{percentage}
            amount: #{amount}
            startAt: "#{start_at}"
            singleUse: #{single_use}
            code: "#{code}"
          }
        PARAMS
      end

      it { expect(subject['coupon']).to include 'name' => 'White Lion' }
      it { expect(subject['coupon']).to include 'active' => true }
      it { expect(subject['coupon']).to include 'amount' => 0 }
      it { expect(subject['coupon']).to include 'code' => 'BROKENHEART' }
      it { expect(subject['coupon']).to include 'singleUse' => true }
      it { expect(subject['coupon']).to include 'startAt' => start_at }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
