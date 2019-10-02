require 'rails_helper'

describe Mutations::Category::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:category) { create(:category, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Ciconia' }
  let(:query) do
    <<~GQL
      mutation {
        updateCategory (
          input: {
            uuid: "#{category.uuid}"
            name: "#{name}"
          }
        ) {
          category {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_category' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['updateCategory'] }

    it { is_expected.to include 'category' => {'name' => 'Ciconia'} }
    it { is_expected.to include 'errors' => [] }
  end
end
