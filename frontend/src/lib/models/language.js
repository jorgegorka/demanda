import { ValidationModel } from "./validation";
import { Languages } from "../database/languages";

function LanguageModel(category = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name.",
      },
    },
    code: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        maximum: 6,
        message: "Please enter a code.",
      },
    },
  };

  const validation = ValidationModel(category, constraints);
  const fields = validation.fields();

  function add() {
    return Languages().add(validValues());
  }

  function edit(languageId) {
    return Languages().edit({
      ...validValues(),
      id: languageId,
    });
  }

  function find(params) {
    return Languages().find(params);
  }

  function findOne(languageId) {
    return Languages().findOne(languageId);
  }

  function remove(languageId) {
    return Languages().remove(languageId);
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
    validValues,
  });
}

export { LanguageModel };
