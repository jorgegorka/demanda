import { ValidationModel } from "./validation";

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
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    },
    parentId: {
      presence: false,
      type: "string"
    }
  };

  const validation = ValidationModel(formFields, constraints);

  return Object.freeze({
    fields: validation.fields,
    valid: validation.valid,
    validate: validation.validate
  });
}

export { CategoryModel };
