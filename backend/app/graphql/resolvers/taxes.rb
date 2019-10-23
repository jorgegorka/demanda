# frozen_string_literal: true

module Resolvers
  class Taxes < Resolvers::Base
    type '[Types::TaxType]', null: true

    description 'Find all taxes or filter by name'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :lang, String, required: false, default_value: ''
    argument :active, Boolean, required: false, default_value: false

    def resolve(uuid:, name:, lang:, active:)
      @db_query = current_account.taxes
      filter_name(name)
      filter_uuid(uuid)
      filter_active(active)
      # filter_translation(lang)

      db_query.order(:name)
    end

    protected

    def filter_active(active)
      @db_query = @db_query.active if active
    end
  end
end
