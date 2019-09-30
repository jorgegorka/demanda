require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it_behaves_like 'price_modifiable'

  it { is_expected.to have_many :orders }

  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_presence_of :name }

  describe 'manual codes' do
    let(:manual_code) { 'SPRING-SALES20' }
    let(:coupon) { create(:coupon, code: manual_code) }

    context 'when a code is assigned manually' do
      subject { coupon.code }

      it { is_expected.to eql manual_code }
    end
  end
end
