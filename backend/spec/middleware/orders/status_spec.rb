# frozen_string_literal: true

require 'rails_helper'

describe Orders::Status do
  describe '#payment_updated' do
    let(:order) { create(:order) }
    let!(:order_item) { create(:order_item, order: order) }

    subject do
      described_class.new(order).payment_updated
      order
    end

    context 'when total paid is lower than total order' do
      it { expect(subject.status).to eql 'received' }
      it { expect { subject }.to change { OrderLog.count }.by(0) }
    end

    context 'when total paid is higher than total order' do
      before { order.stub(:total_paid).and_return(order.total.amount + 2) }

      it { expect(subject.status).to eql 'approved' }
      it { expect { subject }.to change { OrderLog.count }.by(1) }
    end

    context 'when total paid is equal than total order' do
      before { order.stub(:total_paid).and_return(order.total.amount) }

      it { expect(subject.status).to eql 'approved' }
      it { expect { subject }.to change { OrderLog.count }.by(1) }
    end
  end
end
