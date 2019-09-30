require 'rails_helper'

RSpec.describe User do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :account }
  it { is_expected.to have_many :addresses }
  it { is_expected.to have_one(:invoice_address).class_name('Address') }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :account_id }
  it { is_expected.to validate_presence_of :last_name }

  it { should define_enum_for(:role).with(%i[customer admin manager]) }
end
