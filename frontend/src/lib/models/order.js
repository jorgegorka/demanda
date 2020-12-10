import { ValidationModel } from "./validation";
import { Orders } from "../database/orders";

function Order(order = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name.",
      },
    },
    parentId: {
      presence: false,
      type: "string",
    },
    slug: {
      presence: false,
      type: "string",
    },
  };

  const validation = ValidationModel(order, constraints);
  const fields = validation.fields();

  function add() {
    return Orders().add(validValues());
  }

  function edit(orderId) {
    return Orders().edit({
      ...validValues(),
      id: orderId,
    });
  }

  function find(params) {
    return Orders().find(params);
  }

  function findOne(orderId) {
    return Orders().findOne(orderId);
  }

  function remove(orderId) {
    return Orders().remove(orderId);
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

export { Order };
