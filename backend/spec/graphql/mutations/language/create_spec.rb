require 'rails_helper'

describe Mutations::Language::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) {
    <<~RESULT
      {
        name
      }
    RESULT
  }
  let(:query) do
    <<~GQL
      mutation {
        createLanguage (
          #{input_params}
        ) {
          language #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_language' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createLanguage']
    end

    context 'basic input' do
      let(:name) { 'Alcest' }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
          }
        PARAMS
      end

      it { is_expected.to include 'language' => {'name' => 'Alcest'} }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
