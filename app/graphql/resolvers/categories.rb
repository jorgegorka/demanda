# frozen_string_literal: true

module Resolvers
  class Categories < Resolvers::Base
    type '[Types::CategoryType]', null: true

    description 'Find all categories or filter by name'
    argument :name, String, required: false, default_value: ''
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :lang, String, required: false, default_value: ''

    def resolve(name:, uuid:, lang:)
      @db_query = current_account.categories
      filter_name(name)
      filter_uuid(uuid)
      filter_translation(lang)

      db_query
    end
  end
end
