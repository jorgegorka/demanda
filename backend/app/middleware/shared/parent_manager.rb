# frozen_string_literal: true

module Shared
  module ParentManager
    protected

    def find_parent(params)
      parent_type = params.delete(:parent_type)
      parent_id = params.delete(:parent_id)

      @parent = account.send(parent_type).find_by!(uuid: parent_id)
    end

    def find_language(params)
      language_id = params.delete(:language_id)
      if language_id == '0'
        params[:language_id] = nil
      else
        language = account.languages.find_by!(uuid: language_id)
        params[:language_id] = language.id
      end
    end
  end
end
