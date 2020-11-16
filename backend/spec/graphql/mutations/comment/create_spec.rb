# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Comment::Create, type: :request do
  let(:account) { create(:account, domain: 'http://www.example.com') }
  let!(:user) { create(:user, account: account) }
  let!(:language) do
    language = create(:language, account: account)
    account.update(default_language: language.uuid)
    language
  end
  let(:product) { create(:product, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        description
        rating
        user {
          name
        }
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createComment (
          #{input_params}
        ) {
          comment #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_comment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createComment']
    end

    context 'when user is logged in' do
      context 'basic input' do
        let(:description) { 'An amazing comment that I give to you' }
        let(:input_params) do
          <<~PARAMS
            input: {
              description: "#{description}"
              parentId: "#{product.uuid}"
              parentType: "products"
              rating: 3
            }
          PARAMS
        end

        it { is_expected.to include 'comment' => { 'description' => description, 'rating' => 3, 'user' => { 'name' => user.name } } }
        it { is_expected.to include 'errors' => [] }
      end
    end

    context 'when user is logged out' do
      let(:jwt_token) {}

      context 'basic input' do
        let(:description) { 'An amazing comment that I give to you' }
        let(:input_params) do
          <<~PARAMS
            input: {
              description: "#{description}"
              parentId: "#{product.uuid}"
              parentType: "products"
              rating: 3
              userEmail: "new@comment.com"
              userName: "The commenter"
            }
          PARAMS
        end

        it { is_expected.to include 'comment' => { 'description' => description, 'rating' => 3, 'user' => { 'name' => 'The commenter' } } }
        it { is_expected.to include 'errors' => [] }
      end
    end
  end
end
