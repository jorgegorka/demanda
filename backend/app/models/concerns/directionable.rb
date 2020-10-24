require 'active_support/concern'

module Directionable
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable, dependent: :destroy
    has_one :invoice_address, -> { where(invoice: true) }, as: :addressable, class_name: 'Address'
  end

  class_methods do
  end
end
