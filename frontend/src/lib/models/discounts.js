import { ValidationModel } from "./validation";

function DiscountModel(discount) {
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
    minimumPrice: {
      presence: false,
      type: "number"
    },
    minimumQuantity: {
      presence: false,
      type: "number"
    },
    customerId: {
      presence: false,
      type: "string"
    },
    categoryId: {
      presence: false,
      type: "string"
    },
    productId: {
      presence: false,
      type: "string"
    }
  };

  const validation = ValidationModel(discount, constraints);

  return Object.freeze({
    fields: validation.fields,
    valid: validation.valid,
    validValues: validation.validValues
  });
}

export { DiscountModel };
