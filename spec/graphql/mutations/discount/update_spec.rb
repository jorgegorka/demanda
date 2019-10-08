require 'rails_helper'

describe Mutations::Discount::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:discount) { create(:discount, account: account) }
  let(:discount_uuid) { discount.uuid }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Lullaby' }
  let(:query) do
    <<~GQL
      mutation {
        updateDiscount (
          input: {
            id: "#{discount_uuid}"
            name: "#{name}"
          }
        ) {
          discount {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_discount' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateDiscount']
    end

    it { is_expected.to include 'discount' => {'name' => 'Lullaby'} }
    it { is_expected.to include 'errors' => [] }

    context 'if discount uuid is wrong' do
      let(:discount_uuid) { 'wrong' }

      it { is_expected.to_not include 'discount' => {'name' => 'Lullaby'} }
      it { is_expected.to include 'errors' => ['Discount not found'] }
    end
  end
end
