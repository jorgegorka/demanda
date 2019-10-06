# require 'rails_helper'
#
# describe Orders::Persistence do
#   describe '.set_modifiers' do
#     let(:order) { create(:order) }
#
#     context 'when there are no modifiers' do
#       let(:order_item1) { create(:order_item, order: order, price: 1, quantity: 5) }
#
#       subject { described_class.set_modifiers(order) }
#
#       it { expect(order_item1.gross_price_cents).to eql 5 }
#     end
#   end
# end
