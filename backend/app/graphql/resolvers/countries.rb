# frozen_string_literal: true

module Resolvers
  class Countries < Resolvers::Base
    type '[Types::Country]', null: true

    description 'Find all countries'
    argument :id, String, required: false, default_value: '', as: :country_code

    def resolve(country_code:)
      return [country_by_code(country_code)] if country_code.present?

      ::Countries::Presenter.for_api(ISO3166::Country.all)
    end

    private

    def country_by_code(country_code)
      country = Country.find_country_by_alpha3(country_code)

      ::Countries::Presenter.new(country).for_api
    end
  end
end
