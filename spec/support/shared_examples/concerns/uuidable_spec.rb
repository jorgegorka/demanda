require 'rails_helper'

shared_examples_for 'uuidable' do
  # let(:model) { described_class }

  it { is_expected.to validate_presence_of :uuid }
end