import validate from "validate.js";

function FormValidator(formFields, validationConstraints) {
  const fields = Object.keys(formFields);

  function resetErrorInfo() {
    fields.forEach(function(fieldName) {
      formFields[fieldName].message = "";
      formFields[fieldName].error = false;
    });
  }

  function validationContent() {
    const result = {};
    fields.forEach(function(fieldName) {
      result[fieldName] = formFields[fieldName].value;
    });

    return result;
  }

  function addErrors(validationResult) {
    fields.forEach(function(fieldName) {
      if (
        validationResult[fieldName] &&
        validationResult[fieldName].length > 0
      ) {
        formFields[fieldName].message = validationResult[fieldName][0];
        formFields[fieldName].error = true;
      }
    });
  }

  function validateData() {
    resetErrorInfo();
    let valid = true;
    const validationResult = validate(
      validationContent(),
      validationConstraints
    );
    if (validationResult) {
      valid = false;
      addErrors(validationResult);
    }

    return { formFields, valid };
  }

  return Object.freeze({
    validateData
  });
}

export { FormValidator };
