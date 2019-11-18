require 'rails_helper'

describe Mutations::Session::Signup, type: :request do
  let(:login_email) { 'visionsof@atlantis.com' }
  let(:login_password) { 'unbreakable' }
  let(:account_name) { 'Wanderers' }
  let(:login_query) {
    <<~GQL
    mutation {
      signup (
        input: {
          email: "#{login_email}"
          password: "#{login_password}"
          name: "#{account_name}"
        }
      ) {
        token
        errors
      }
    }
    GQL
  }

  describe 'login' do
    before do
      post '/graphql', params: { query: login_query }
    end

    subject { parse_graphql_response(response.body)['signup'] }

    describe 'when login details are correct' do
      it { is_expected.to include 'errors' => [] }
      it { is_expected.to include 'token' }
      it { expect { post '/graphql', params: { query: login_query } }.to change{ Account.count }.by(1) }
      it { expect { post '/graphql', params: { query: login_query } }.to change{ User.count }.by(1) }
    end
  end
end
