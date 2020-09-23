# frozen_string_literal: true

module Resolvers
  class Categories < Resolvers::Base
    type '[Types::CategoryType]', null: true

    description 'Find all categories or filter by name'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :slug, String, required: false, default_value: ''
    argument :all, Boolean, required: false, default_value: false
    argument :lang, String, required: false, default_value: ''

    def resolve(uuid:, name:, slug:, lang:, all:)
      @db_query = current_account.categories
      filter_name(name)
      filter_slug(slug)
      filter_uuid(uuid) unless all
      # filter_translation(lang)

      db_query.order(:name)
    end

    protected

    def filter_uuid(uuid)
      @db_query = if uuid.blank?
                    db_query.where(parent_id: nil)
                  else
                    db_query.where(uuid: uuid)
                  end
    end
  end
end
