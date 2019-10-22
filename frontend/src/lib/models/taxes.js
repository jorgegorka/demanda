import { ValidationModel } from "./validation";

function TaxModel(tax) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    },
    active: {
      presence: true,
      type: "boolean"
    },
    percentage: {
      presence: false,
      type: "number"
    },
    amount: {
      presence: false,
      type: "number"
    },
    startAt: {
      presence: true
    },
    endAt: {
      presence: false
    },
    minimum_price: {
      presence: false,
      type: "number"
    },
    minimum_quantity: {
      presence: false,
      type: "number"
    }
  };

  const validation = ValidationModel(tax, constraints);

  return Object.freeze({
    fields: validation.fields,
    valid: validation.valid,
    validValues: validation.validValues
  });
}

export { TaxModel };
