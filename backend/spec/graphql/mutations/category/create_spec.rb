# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Category::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        name
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createCategory (
          #{input_params}
        ) {
          category #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_category' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createCategory']
    end

    context 'basic input' do
      let(:name) { 'Ciconia' }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
          }
        PARAMS
      end

      it { is_expected.to include 'category' => { 'name' => 'Ciconia' } }
      it { is_expected.to include 'errors' => [] }
    end

    context 'input with parent category' do
      let(:parent) { create(:category, account: account) }
      let(:name) { 'Winterize' }
      let(:result_info) do
        <<~RESULT
          {
            name
            parent {
              name
            }
          }
        RESULT
      end
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            parentId: "#{parent.uuid}"
          }
        PARAMS
      end

      it { is_expected.to include 'category' => { 'name' => 'Winterize', 'parent' => { 'name' => parent.name } } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
