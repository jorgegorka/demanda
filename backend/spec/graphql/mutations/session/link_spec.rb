require 'rails_helper'

describe Mutations::Session::Link, type: :request do
  let!(:user) { create(:user) }
  let(:user_code) { user.generate_login_code }
  let(:login_query) do
    <<~GQL
      mutation {
        loginLink (
          input: {
            code: "#{user_code}"
          }
        ) {
          token
          errors
        }
      }
    GQL
  end

  describe 'login' do
    before do
      post '/graphql', params: { query: login_query }
    end

    subject { parse_graphql_response(response.body)['loginLink'] }

    describe 'with wrong login details' do
      context 'invalid code' do
        let(:user_code) { 'invalid' }

        it { is_expected.to include 'errors' => ['Invalid code'] }
      end
    end

    describe 'when login details are correct' do
      it { is_expected.to include 'errors' => [] }
      it { is_expected.to include 'token' }
    end
  end
end
