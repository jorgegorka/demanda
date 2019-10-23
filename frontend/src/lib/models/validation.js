import { FormValidator } from "../utils/form_validator";
import { memoize } from "../utils/memoize";

function ValidationModel(model, constraints) {
  const baseFields = Object.keys(constraints);

  function fields() {
    const modelFields = memoize(generateFormFields);

    return modelFields(baseFields);
  }

  function generateFormFields(fields) {
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
