# frozen_string_literal: true

module Resolvers
  class Categories < Resolvers::Base
    type '[Types::CategoryType]', null: true

    description 'Find all categories or filter by name'
    argument :name, String, required: false, default_value: ''
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :parent_id, String, required: false, default_value: nil
    argument :lang, String, required: false, default_value: ''

    def resolve(name:, uuid:, lang:, parent_id:)
      @db_query = current_account.categories
      filter_parent(parent_id)
      filter_name(name)
      filter_uuid(uuid)
      filter_translation(lang)

      db_query.order(:name)
    end

    protected

    def filter_parent(parent_id)
      @db_query = db_query.where(parent_id: parent_id)
    end
  end
end
