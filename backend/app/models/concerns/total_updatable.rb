# frozen_string_literal: true

require 'active_support/concern'

module TotalUpdatable
  extend ActiveSupport::Concern

  included do

  end

  def update_total
    self.total_discount = 0
    self.total_tax = 0
    price_modifiers.each do |price_modifier|
      price_calculator = Price::Calculator.new(price_modifier, total_net.amount)
      price_calculator.calculate
      self.total_discount = total_discount.amount + price_calculator.total_discount.amount
      self.total_tax = total_tax.amount + price_calculator.total_tax.amount
    end

    save
  end

  class_methods do
  end
end
