require 'rails_helper'

describe Attachments::Persistence do
  let(:account) { create(:account) }
  let(:parent) { create(:product, account: account) }
  let(:url) { 'https://www.my-images.com/path/to/image.png' }
  let(:title) { 'Behemoth' }
  let(:params) { { title: title, url: url, parent_id: parent.uuid, parent_type: 'products' } }
  let(:attachment_persistence) { described_class.new(account) }

  describe '.create' do
    it { expect { attachment_persistence.create(params) }.to change{ Attachment.count }.by(1) }
  end

  describe '.destroy' do
    let!(:attachment) { parent.attachments.create(title: title, url: url) }
    let(:params) { { id: attachment.uuid, parent_id: parent.uuid, parent_type: 'products' } }

    it { expect { attachment_persistence.destroy(params) }.to change{ Attachment.count }.by(-1) }
  end
end
