import { ValidationModel } from "./validation";
import { Translations } from "../database/translations";

function TranslationModel(translation = {}) {
  const constraints = {
    parentType: {
      presence: true,
      type: "string"
    },
    parentId: {
      presence: true,
      type: "string"
    },
    languageId: {
      presence: true,
      type: "string"
    },
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    },
    description: {
      presence: false,
      type: "string"
    }
  };

  const validation = ValidationModel(translation, constraints);
  const fields = validation.fields();

  function add(graphqlClient) {
    return Translations(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, translationId) {
    return Translations(graphqlClient).edit({
      ...validValues(),
      id: translationId
    });
  }

  function find(graphqlClient, params) {
    return Translations(graphqlClient).find(params);
  }

  function findOne(graphqlClient, translationId) {
    return Translations(graphqlClient).findOne(translationId);
  }

  function remove(graphqlClient, params) {
    return Translations(graphqlClient).remove(params);
  }

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    add,
    edit,
    fields,
    find,
    findOne,
    remove,
    valid,
    validValues
  });
}

export { TranslationModel };
