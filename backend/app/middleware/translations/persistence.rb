module Translations
  class Persistence
    attr_reader :account, :parent

    def initialize(account)
      @account = account
    end

    def create(params)
      find_translation_info(params)
      translation = parent.translations.create(params)

      translation
    end

    def update(params)
      find_translation_info(params)
      translation = parent.translations.find_by(uuid: params.delete(:id))
      translation.update(params)

      translation
    end

    def destroy(params)
      find_translation_info(params)
      translation = parent.translations.find_by(uuid: params.delete(:id))
      translation.destroy

      translation
    end

    protected

    def find_translation_info(params)
      @parent = find_parent(params)
      find_language(params) if params[:language_id]
    end

    def find_parent(params)
      parent_type = params.delete(:parent_type)
      parent_id = params.delete(:parent_id)

      account.send(parent_type).find_by(uuid: parent_id)
    end

    def find_language(params)
      language_id = params.delete(:language_id)
      language = account.languages.find_by(uuid: language_id)
      params[:language_id] = language.id
    end
  end
end
