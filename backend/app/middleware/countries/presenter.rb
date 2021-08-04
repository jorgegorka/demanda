module Countries
  class Presenter
    attr_reader :country

    class << self
      def for_api(countries)
        countries.map{ |country| new(country).for_api }
      end
    end

    def initialize(country)
      @country = country
    end

    def for_api
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
end
