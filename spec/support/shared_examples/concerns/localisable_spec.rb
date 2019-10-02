require 'rails_helper'

shared_examples_for 'localisable' do
  it { is_expected.to have_many :translations }
end
