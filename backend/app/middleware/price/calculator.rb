# frozen_string_literal: true

module Price
  class Calculator
    attr_reader :total_gross, :price_modifier, :total_tax, :total_discount

    def initialize(price_modifier, total_gross)
      @total_gross = total_gross
      @price_modifier = price_modifier
      @total_tax = Money.new(0, 'EU2')
      @total_discount = Money.new(0, 'EU2')
    end

    def calculate
      price_modifier.tax? ? add_to_tax : add_to_discount
    end

    protected

    def add_to_tax
      @total_tax = total_to_add
    end

    def add_to_discount
      @total_discount = total_to_add
    end

    def total_to_add
      price_modifier.amount.zero? ? percentage_number : price_modifier.amount
    end

    def percentage_number
      Money.new(total_percentage.to_f * 100, 'EU2')
    end

    def total_percentage
      total_gross * price_modifier.percentage.amount / 100
    end
  end
end
