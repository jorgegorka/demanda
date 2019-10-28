require 'rails_helper'

RSpec.describe Account, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'directionable'

  it { is_expected.to have_many :users }
  it { is_expected.to have_many :categories }
  it { is_expected.to have_many :taxes }
  it { is_expected.to have_many :discounts }
  it { is_expected.to have_many :coupons }
  it { is_expected.to have_many :products }
  it { is_expected.to have_many :customers }
  it { is_expected.to have_many :orders }
  it { is_expected.to have_many :languages }

  it { is_expected.to have_one(:admin).class_name('User') }

  it { is_expected.to validate_presence_of(:name) }
end
