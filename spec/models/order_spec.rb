require 'rails_helper'

RSpec.describe Order, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to :customer }

  it { is_expected.to have_many :order_items }
  it { is_expected.to have_many :order_price_modifiers }

  it { is_expected.to validate_presence_of :account_id }
  it { is_expected.to validate_presence_of :customer_id }

  it { should define_enum_for(:status).with(%i[card confirmed delivered received rejected cancelled]) }
end
