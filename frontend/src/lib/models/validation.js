import { FormValidator } from "../utils/form_validator";
import { memoize } from "../utils/memoize";

function ValidationModel(model, constraints) {
  const baseFields = Object.keys(model);

  function fields() {
    const modelFields = memoize(generateFields);

    return modelFields(baseFields);
  }

  function generateFields(fields) {
    const result = {};
    fields.forEach(function(field) {
      result[field] = {
        value: model[field],
        error: false,
        message: ""
      };
    });

    return result;
  }

  function valid(formFields) {
    return FormValidator(formFields, constraints).validateData();
  }

  function validValues(formFields) {
    const result = {};
    baseFields.forEach(field => (result[field] = formFields[field].value));

    return result;
  }

  return Object.freeze({
    fields,
    valid,
    validValues
  });
}

export { ValidationModel };
