require 'rails_helper'

describe Mutations::Category::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:category) { create(:category, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
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
      it { is_expected.to include 'message' => 'Category was deleted' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when category has products associated' do
      let!(:product) { create(:product, category: category) }

      it { is_expected.to include 'message' => "Can't delete." }
      it { is_expected.to include 'errors' => ['Category should have no products associated.'] }
    end
  end
end
