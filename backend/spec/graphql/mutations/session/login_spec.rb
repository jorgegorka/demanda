require 'rails_helper'

describe Mutations::Session::Login, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let!(:user) { create(:user, password: password, email: email) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:login_query) do
    <<~GQL
    mutation {
      login (
        input: {
          email: "#{login_email}"
          password: "#{login_password}"
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

    subject { parse_graphql_response(response.body)['login'] }

    describe 'with wrong login details' do
      context 'invalid email' do
        let(:login_email) { 'invalid@email.es' }

        it { is_expected.to include 'errors' => ['Invalid email or password'] }
      end

      context 'invalid password' do
        let(:login_password) { 'password' }

        it { is_expected.to include 'errors' => ['Invalid email or password'] }
      end
    end

    describe 'when login details are correct' do
      it { is_expected.to include 'errors' => [] }
      it { is_expected.to include 'token' }
    end
  end
end
