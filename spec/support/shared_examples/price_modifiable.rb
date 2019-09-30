shared_examples_for 'price_modifiable' do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :account }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_at }

  describe 'amount or percentage should be present' do
    let(:account) { create(:account) }
    let(:amount) { nil }
    let(:percentage) { nil }
    let(:modifier) { described_class.new(account: account, name: 'price modifier', amount: amount, percentage: percentage) }

    subject { modifier.valid? }

    context 'when amount is present' do
      let(:amount) { 15.99 }

      it { is_expected.to be true }
    end

    context 'when percentage is present' do
      let(:amount) { 8.65 }

      it { is_expected.to be true }
    end

    context 'when both are present' do
      let(:amount) { 15.99 }
      let(:percentage) { 8.65 }

      it { is_expected.to be false }
    end

    context 'when none are present' do
      it { is_expected.to be false }
    end
  end
end
