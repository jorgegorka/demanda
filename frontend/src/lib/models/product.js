import { ValidationModel } from "./validation";
import { Products } from "../database/products";

function ProductModel(product = {}) {
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

  function add(graphqlClient) {
    return Products(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, taxId) {
    return Products(graphqlClient).edit({
      ...validValues(),
      id: taxId
    });
  }

  function find(graphqlClient, params) {
    return Products(graphqlClient).find(params);
  }

  function findOne(graphqlClient, discountId) {
    return Products(graphqlClient).findOne(discountId);
  }

  function remove(graphqlClient, discountId) {
    return Products(graphqlClient).remove(discountId);
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

export { ProductModel };
