import { ValidationModel } from "./validation";
import { Discounts } from "../database/discounts";

function DiscountModel(discount = {}) {
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
  const fields = validation.fields();

  function add(graphqlClient) {
    return Discounts(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, discountId) {
    return Discounts(graphqlClient).edit({
      ...validValues(),
      id: discountId
    });
  }

  function find(graphqlClient, params) {
    return Discounts(graphqlClient).find(params);
  }

  function findOne(graphqlClient, discountId) {
    return Discounts(graphqlClient).findOne(discountId);
  }

  function remove(graphqlClient, discountId) {
    return Discounts(graphqlClient).remove(discountId);
  }

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    add,
    edit,
    fields,
    find,
    findOne,
    remove,
    valid,
    validValues
  });
}

export { DiscountModel };
