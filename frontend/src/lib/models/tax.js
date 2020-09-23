import { ValidationModel } from "./validation";
import { Taxes } from "../database/taxes";

function TaxModel(tax = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name.",
      },
    },
    active: {
      presence: true,
      type: "boolean",
    },
    percentage: {
      presence: false,
      type: "number",
    },
    amount: {
      presence: false,
      type: "number",
    },
    startAt: {
      presence: true,
    },
    endAt: {
      presence: false,
    },
    minimumPrice: {
      presence: false,
      type: "number",
    },
    userId: {
      presence: false,
      type: "string",
    },
    categoryId: {
      presence: false,
      type: "string",
    },
    productId: {
      presence: false,
      type: "string",
    },
  };

  const validation = ValidationModel(tax, constraints);
  const fields = validation.fields();

  function add() {
    return Taxes().add(validValues());
  }

  function edit(taxId) {
    return Taxes().edit({
      ...validValues(),
      id: taxId,
    });
  }

  function find(params) {
    return Taxes().find(params);
  }

  function findOne(discountId) {
    return Taxes().findOne(discountId);
  }

  function remove(discountId) {
    return Taxes().remove(discountId);
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
    validValues,
  });
}

export { TaxModel };
