import { ValidationModel } from "./validation";
import { Products } from "../database/products";

function ProductModel(product = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name.",
      },
    },
    categoryId: {
      presence: false,
      type: "string",
    },
    price: {
      presence: true,
      type: "number",
    },
    stock: {
      presence: true,
      type: "number",
    },
    slug: {
      presence: false,
      type: "string",
    },
    tags: {
      presence: false,
      type: "string",
    },
  };

  const validation = ValidationModel(product, constraints);
  const fields = validation.fields();

  function add() {
    return Products().add(validValues());
  }

  function edit(taxId) {
    return Products().edit({
      ...validValues(),
      id: taxId,
    });
  }

  function find(params) {
    return Products().find(params);
  }

  function findOne(discountId) {
    return Products().findOne(discountId);
  }

  function remove(discountId) {
    return Products().remove(discountId);
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

export { ProductModel };
