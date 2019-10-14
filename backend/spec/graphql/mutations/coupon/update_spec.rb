require 'rails_helper'

describe Mutations::Coupon::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:coupon) { create(:coupon, account: account) }
  let(:coupon_uuid) { coupon.uuid }
  let(:code) { 'SUMMERSALES21' }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Midnight Oil' }
  let(:query) do
    <<~GQL
      mutation {
        updateCoupon (
          input: {
            id: "#{coupon_uuid}"
            name: "#{name}"
            code: "#{code}"
          }
        ) {
          coupon {
            name
            code
          }
          errors
        }
      }
    GQL
  end

  describe 'update_coupon' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateCoupon']
    end

    it { expect(subject['coupon']).to include 'name' => 'Midnight Oil' }
    it { expect(subject['coupon']).to include 'code' => 'SUMMERSALES21' }
    it { is_expected.to include 'errors' => [] }

    context 'if coupon uuid is wrong' do
      let(:coupon_uuid) { 'wrong' }

      it { expect(subject['coupon']).to be_nil }
      it { is_expected.to include 'errors' => ['Coupon not found'] }
    end
  end
end
