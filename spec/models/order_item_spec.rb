require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :product }

  it { is_expected.to have_many :order_price_modifiers }
end
