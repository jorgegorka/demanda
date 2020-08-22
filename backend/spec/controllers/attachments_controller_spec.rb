# frozen_string_literal: true

require 'rails_helper'

describe AttachmentsController do
  describe '#create' do
    let(:user) { create(:user) }
    let(:account) { user.account }
    let(:product) { create(:product, account: account) }
    let(:product_uuid) { product.uuid }
    let!(:jwt_token) { generate_jwt_test_token(user) }
    let(:params) do
      {
        parent_id: product_uuid,
        parent_type: 'products',
        files: fixture_file_upload('spec/files/image.png'),
        title: 'My title',
        language_id: '0'
      }
    end

    subject do
      request.headers['Authorization'] = "Bearer #{jwt_token}"
      post :create, params: params

      response
    end

    context 'request with invalid jwt token' do
      let(:jwt_token) {}

      it { is_expected.to have_http_status :unauthorized }
    end

    context 'request with invalid product' do
      let(:product_uuid) { '234' }

      it { is_expected.to have_http_status :not_found }
    end

    context 'valid params' do
      it { is_expected.to have_http_status :success }
    end
  end
end
