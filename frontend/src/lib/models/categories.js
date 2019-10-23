import { ValidationModel } from "./validation";

function CategoryModel(category) {
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

  const validation = ValidationModel(category, constraints);

  return Object.freeze({
    fields: validation.fields,
    valid: validation.valid,
    validValues: validation.validValues
  });
}

export { CategoryModel };
