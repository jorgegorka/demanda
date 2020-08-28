# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  let(:description) { '<div id="top-bar">Strip <i>these</i> tags!</div>' }

  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :commentable }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :language }

  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_length_of(:description).is_at_most(800) }
  it { is_expected.to validate_inclusion_of(:rating).in_range(0..5) }

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
