module Types
  class LanguageType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :description, String, null: true
    field :translations, [Types::TranslationType], null: true
  end
end
