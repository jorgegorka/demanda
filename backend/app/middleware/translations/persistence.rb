module Translations
  class Persistence
    include Shared::ParentManager

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
      find_parent(params)
      find_language(params) if params[:language_id]
    end
  end
end
