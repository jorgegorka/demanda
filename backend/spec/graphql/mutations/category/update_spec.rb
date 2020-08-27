# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Category::Update, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:category) { create(:category, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Spiritual Instinct' }
  let(:query) do
    <<~GQL
      mutation {
        updateCategory (
          input: {
            id: "#{category.uuid}"
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
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateCategory']
    end

    it { is_expected.to include 'category' => { 'name' => 'Spiritual Instinct' } }
    it { is_expected.to include 'errors' => [] }
  end
end
