import { ValidationModel } from "./validation";
import { UserQuery } from "../database/users";

function User(user = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name.",
      },
    },
    phone: {
      presence: false,
    },
  };

  const validation = ValidationModel(user, constraints);
  const fields = validation.fields();

  function add() {
    return UserQuery().add(validValues());
  }

  function edit(taxId) {
    return UserQuery().edit({
      ...validValues(),
      id: taxId,
    });
  }

  function find(params) {
    return UserQuery().find(params);
  }

  function findOne(discountId) {
    return UserQuery().findOne(discountId);
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
    valid,
    validValues,
  });
}

export { User };
