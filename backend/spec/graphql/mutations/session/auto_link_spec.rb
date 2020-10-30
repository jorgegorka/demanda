# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Session::AutoLink, type: :request do
  let!(:user) { create(:user) }
  let(:auto_link_query) do
    <<~GQL
      mutation AutoLink {
        autoLink (
          input: {
            email: "#{user.email}"
          }
        ) {
          errors
        }
      }
    GQL
  end

  describe 'generate' do
    subject do
      post '/graphql', params: { query: auto_link_query }
      parse_graphql_response(response.body)['autoLink']
    end

    it { is_expected.to include 'errors' => [] }

    xit { expect { subject }.to change { user.magic_login_token }.from(NilClass).to(String) }
  end
end
