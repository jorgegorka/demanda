import { FormValidator } from "../utils/form_validator";

function CategoryModel(category) {
  let formFields = {
    name: {
      value: category.name,
      error: false,
      message: ""
    },
    parentId: {
      value: category.parentId
    }
  };

  const constraints = {
    name: {
      presence: true,
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    },
    parentId: {
      presence: false
    }
  };

  function fields() {
    return formFields;
  }

  function valid() {
    const { _fields, valid } = validate();

    return valid;
  }

  function validate() {
    return FormValidator(formFields, constraints).validateData();
  }

  return Object.freeze({
    fields,
    valid,
    validate
  });
}

export { CategoryModel };
