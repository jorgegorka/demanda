import { ValidationModel } from "./validation";

function ProductModel(product) {
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

  const validation = ValidationModel(product, constraints);
  const fields = validation.fields();

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    fields,
    valid,
    validValues
  });
}

export { ProductModel };
