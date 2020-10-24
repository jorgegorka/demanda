# frozen_string_literal: true

module Resolvers
  class Countries < Resolvers::Base
    type '[Types::CountryType]', null: true

    description 'Find all countries'
    argument :id, String, required: false, default_value: '', as: :country_code

    def resolve(country_code:)
      return [country_by_code(country_code)] if country_code.present?

      ISO3166::Country.all.map do |country|
        {
          id: country.alpha3,
          name: country.name,
          translations: country.translations.to_json,
          continent: country.continent,
          region: country.region,
          subregion: country.subregion,
          world_region: country.world_region,
          eu_member: country.in_eu?
        }
      end
    end

    def country_by_code(country_code)
      country = Country.find_country_by_alpha3(country_code)

      {
        id: country.country_code || country.alpha3,
        name: country.name,
        translations: country.translations.to_json,
        continent: country.continent,
        region: country.region,
        subregion: country.subregion,
        world_region: country.world_region,
        eu_member: country.in_eu?
      }
    end
  end
end
