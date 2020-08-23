# frozen_string_literal: true

require 'rails_helper'

describe AttachmentsController do
  let(:user) { create(:admin) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:product_uuid) { product.uuid }
  let!(:jwt_token) { generate_jwt_test_token(user) }

  before do
    request.headers['Authorization'] = "Bearer #{jwt_token}"
  end

  describe '#create' do
    let(:uploaded_file) { fixture_file_upload('spec/files/image.png') }
    let(:params) do
      {
        parent_id: product_uuid,
        parent_type: 'products',
        files: uploaded_file,
        title: 'My title',
        language_id: '0'
      }
    end

    context 'attachment' do
      subject do
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

      context 'request with invalid file' do
        let(:uploaded_file) { '234' }

        it { is_expected.to have_http_status :bad_request }
      end

      context 'request with no file' do
        let(:uploaded_file) {}

        it { is_expected.to have_http_status :bad_request }
      end

      context 'valid params' do
        it { is_expected.to have_http_status :success }
      end
    end

    context 'attachment' do
      subject { post :create, params: params }

      it { expect { subject }.to change { product.attachments.count }.by(1) }

      it 'should have a media item attached' do
        subject
        attachment = product.reload.attachments.first

        expect(attachment.media_item.attached?).to be true
      end

      it 'should generate a public url with the account domain' do
        subject
        attachment = product.reload.attachments.first

        expect(attachment.url.include?(account.domain)).to be true
      end
    end
  end

  describe '#destroy' do
    let(:attachment) { create(:attachment, :with_media, attachable_id: product.id, attachable_type: product.class.to_s) }
    let(:attachment_uuid) { attachment.uuid }
    let(:params) { { id: attachment_uuid } }

    subject do
      delete :destroy, params: params
      response
    end

    context 'request with invalid jwt token' do
      let(:jwt_token) {}

      it { is_expected.to have_http_status :unauthorized }
    end

    context 'request with invalid product' do
      let(:attachment_uuid) { '234' }

      it { is_expected.to have_http_status :not_found }
    end

    context 'a valid request' do
      it { is_expected.to have_http_status :success }
    end
  end
end
