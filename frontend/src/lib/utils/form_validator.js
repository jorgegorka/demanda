import validate from "validate.js";
import { format, parse } from "date-fns";

validate.extend(validate.validators.datetime, {
  parse: function(value, options) {
    const formater = options.dateOnly ? "yyyy-MM-dd" : "yyyy-MM-dd hh:mm:ss";

    return +parse(value, formater, new Date());
  },
  format: function(value, options) {
    const formater = options.dateOnly ? "dd-MM-yyyy" : "dd-MM-yyyy hh:mm:ss";

    return format(value, formater);
  }
});

function FormValidator(fieldsInfo, validationConstraints) {
  const fields = Object.keys(fieldsInfo);

  function resetErrorInfo() {
    fields.forEach(function(fieldName) {
      fieldsInfo[fieldName].message = "";
      fieldsInfo[fieldName].error = false;
    });
  }

  function validationContent() {
    const result = {};
    fields.forEach(function(fieldName) {
      result[fieldName] = fieldsInfo[fieldName].value;
    });

    return result;
  }

  function addErrors(validationResult) {
    fields.forEach(function(fieldName) {
      if (
        validationResult[fieldName] &&
        validationResult[fieldName].length > 0
      ) {
        fieldsInfo[fieldName].message = validationResult[fieldName][0];
        fieldsInfo[fieldName].error = true;
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

    return valid;
  }

  return Object.freeze({
    validateData
  });
}

export { FormValidator };
