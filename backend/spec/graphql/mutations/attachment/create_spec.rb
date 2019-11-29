require 'rails_helper'

describe Mutations::Attachment::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        title
        url
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createAttachment (
          #{input_params}
        ) {
          attachment #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_attachment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createAttachment']
    end

    context 'basic input' do
      let(:product) { create(:product, account: account) }
      let(:title) { 'Ozzy Osburne' }
      let(:url) { 'https://some-image.com/container/image.jpg' }
      let(:input_params) do
        <<~PARAMS
          input: {
            parentId: "#{product.uuid}"
            parentType: products
            title: "#{title}"
            url: "#{url}"
          }
        PARAMS
      end

      it { is_expected.to include 'attachment' => { 'title' => title, 'url' => url } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
