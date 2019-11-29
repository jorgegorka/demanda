require 'rails_helper'

shared_examples_for 'attachable' do
  it { is_expected.to have_many :attachments }
end
