require 'rails_helper'

describe Mutations::Coupon::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:coupon) { create(:coupon, account: account) }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteCoupon (
          input: {
            id: "#{coupon.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_coupon' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteCoupon']
    end

    it { is_expected.to include 'message' => 'Coupon was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
