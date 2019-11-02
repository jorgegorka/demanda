require 'rails_helper'

RSpec.describe Customer, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'directionable'

  it { is_expected.to belong_to :account }

  it { is_expected.to have_one :cart }

  it { is_expected.to have_many :orders }

  it { is_expected.to validate_presence_of :name }
end
