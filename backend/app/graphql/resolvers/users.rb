# frozen_string_literal: true

module Resolvers
  class Users < Resolvers::Base
    type [Types::UserType], null: true

    description 'Find all taxes or filter by name'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :email, String, required: false, default_value: ''

    def resolve(uuid:, name:, email:)
      @db_query = current_account.users
      filter_name(name)
      filter_email(email)
      filter_uuid(uuid)

      db_query.order(:name)
    end

    private

    def filter_email(email)
      return db_query if email.blank?

      @db_query = db_query.where(email: email)
    end
  end
end
