# frozen_string_literal: true

require 'rails_helper'

describe Comments::Persistence do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:language) { create(:language, account: account) }
  let(:parent) { create(:product, account: account) }
  let(:description) { 'lorem' }
  let(:params) do
    {
      description: description,
      parent_id: parent.uuid,
      parent_type: 'products',
      user_id: user.id,
      language_id: language.id
    }
  end
  let(:comment_persistence) { described_class.new(account) }

  describe '.create' do
    subject { comment_persistence.create(params) }

    it { expect { subject }.to change { Comment.count }.by(1) }

    context 'when description has html code' do
      let(:description) { '<p>clean<script>console.log("evil")</script></p>' }

      it { expect(subject.description).to eql('clean') }
    end
  end

  describe '.update' do
    let(:comment) { create(:comment, account: account, user: user) }
    let(:params) { { id: comment.uuid, reply_description: 'Seemannsgarn by Tanzwut', approved: true } }

    subject { comment_persistence.update(params) }

    it { expect(subject.reply_description).to eql 'Seemannsgarn by Tanzwut' }
    it { expect(subject.approved).to be true }
  end

  describe '.destroy' do
    let!(:comment) { create(:comment) }

    it { expect { comment_persistence.destroy(comment) }.to change { Comment.count }.by(-1) }
  end
end
