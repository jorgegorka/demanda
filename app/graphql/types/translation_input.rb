class Types::TranslationInput < Types::BaseInputObject
  description 'Attributes for creating a translation'
  argument :language, String, required: true
  argument :name, String, required: true
  argument :description, String, required: false
end
