require 'rails_helper'

describe Mutations::Category::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:category) { create(:category, account: account) }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteCategory (
          input: {
            id: "#{category.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_category' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteCategory']
    end

    context 'when there are no products associated' do
      it { is_expected.to include 'message' => 'true' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when category has products associated' do
      let!(:product) { create(:product, category: category) }

      it { is_expected.to include 'message' => 'false' }
      it { is_expected.to include 'errors' => ['Category should have no products or subcategories associated'] }
    end

    context 'when category has subcategories associated' do
      let!(:sub_category) { create(:category, parent: category, account: account) }

      it { is_expected.to include 'message' => 'false' }
      it { is_expected.to include 'errors' => ['Category should have no products or subcategories associated'] }
    end
  end
end
