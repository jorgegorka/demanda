# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  let(:description) { '<div id="top-bar">Strip <i>these</i> tags!</div>' }

  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :commentable }
  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :language }

  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_length_of(:description).is_at_most(800) }
  it { is_expected.to validate_inclusion_of(:rating).in_range(0..5) }

  context 'default language' do
    let(:user) { create(:user) }
    let!(:language) do
      account = user.account
      language = create(:language, account: account)
      account.update(default_language: language.uuid)
      language
    end
    let(:product) { create(:product, account: user.account) }
    let(:params) do
      {
        account_id: user.account.id,
        description: 'some comment about stuff',
        rating: 4,
        approved: true,
        commentable_id: product.id,
        commentable_type: 'Product',
        user_id: user.id
      }
    end

    subject { user.account.comments.build(params) }

    it { expect(subject.valid?).to be true }

    context 'product rating should be updated' do
      before { subject.save }

      it { expect(product.reload.rating).to eql 80 }
    end
  end

  context 'when description has html tags' do
    subject do
      comment.description = description
      comment.save!
      comment.reload.description
    end

    it { is_expected.to eql('Strip these tags!') }
  end

  describe '#reply_description' do
    before do
      comment.reply_description = description
      comment.save!
    end

    context 'when description has html tags' do
      subject { comment.reload.reply_description }

      it { is_expected.to eql('Strip these tags!') }
    end

    context 'when reply description is updated' do
      subject { comment.reload.replied_at }

      it { is_expected.to be }
    end
  end
end
