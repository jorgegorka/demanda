# frozen_string_literal: true

module Resolvers
  class CurrentUser < Resolvers::Base
    type Types::User, null: true

    description 'Find the info for the current user'
    argument :id, String, required: false, default_value: '', as: :uuid

    def resolve(_params)
      current_user
    end
  end
end
