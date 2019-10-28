import { ValidationModel } from "./validation";
import { Languages } from "../database/languages";

function LanguageModel(category = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    }
  };

  const validation = ValidationModel(category, constraints);
  const fields = validation.fields();

  function add(graphqlClient) {
    return Languages(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, languageId) {
    return Languages(graphqlClient).edit({
      ...validValues(),
      id: languageId
    });
  }

  function find(graphqlClient, params) {
    return Languages(graphqlClient).find(params);
  }

  function findOne(graphqlClient, languageId) {
    return Languages(graphqlClient).findOne(languageId);
  }

  function remove(graphqlClient, languageId) {
    return Languages(graphqlClient).remove(languageId);
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

export { LanguageModel };
