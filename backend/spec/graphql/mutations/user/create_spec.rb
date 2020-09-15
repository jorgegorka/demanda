# frozen_string_literal: true

require 'rails_helper'

describe Mutations::User::Create, type: :request do
  let(:user) { create(:user) }
  let!(:account) { user.account }
  let(:name) { 'November Doom' }
  let(:email) { 'november@doom.com' }
  let(:password) { 'Hamartia' }
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
        createUser (
          input: {
            name: "#{name}"
            email: "#{email}"
            password: "#{password}"
          }
        ) {
          user #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_user' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createUser']
    end

    context 'when there is a logged in user' do
      let!(:jwt_token) { generate_jwt_test_token(user) }

      it { is_expected.to include 'user' => { 'name' => user.name } }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when there is no user' do
      let(:language) { create(:language) }
      let!(:jwt_token) {}

      before { account.update(default_language: language.uuid, domain: 'http://www.example.com') }

      it { is_expected.to include 'user' => { 'name' => 'November Doom' } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
