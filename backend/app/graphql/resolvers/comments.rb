# frozen_string_literal: true

module Resolvers
  class Comments < Resolvers::Base
    type '[Types::CommentType]', null: true

    description 'Find all comments or filter by approved'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :approved, Boolean, required: false
    argument :lang, String, required: false, default_value: ''

    def resolve(params)
      @db_query = current_account.comments
      filter_approved(params[:approved])
      # filter_translation(params['lang'])

      db_query.order(created_at: :desc)
    end

    protected

    def filter_approved(approved)
      return if approved.nil?

      @db_query = if approved
                    db_query.approved
                  else
                    db_query.pending
                  end
    end
  end
end
