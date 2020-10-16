# frozen_string_literal: true

require 'rails_helper'

describe Mutations::User::AuthCode, type: :request do
  let(:account) { create(:account, domain: 'http://www.example.com') }
  let!(:user) { create(:user, account: account) }
  let(:user_email) { user.email }
  let(:auth_query) do
    <<~GQL
      mutation {
        authCode (
          input: {
            email: "#{user_email}"
          }
        ) {
          errors
        }
      }
    GQL
  end

  describe 'auth_code' do
    before do
      post '/graphql', params: { query: auth_query }
    end

    subject { parse_graphql_response(response.body)['authCode'] }

    describe 'with wrong email' do
      context 'invalid code' do
        let(:user_email) { 'invalid' }

        it { is_expected.to include 'errors' => [] }
      end
    end

    describe 'with valid email' do
      it { is_expected.to include 'errors' => [] }
    end
  end
end
