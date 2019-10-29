module Types
  class TranslationType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :description, String, null: true
    field :language, Types::LanguageType, null: true
  end
end
