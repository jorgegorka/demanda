require 'rails_helper'

shared_examples_for 'directionable' do
  it { is_expected.to have_many :addresses }

  it { is_expected.to have_one(:invoice_address).class_name('Address') }
end
