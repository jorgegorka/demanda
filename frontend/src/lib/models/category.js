import { ValidationModel } from "./validation";
import { Categories } from "../database/categories";

function CategoryModel(category = {}) {
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
  const fields = validation.fields();

  function add(graphqlClient) {
    return Categories(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, categoryId) {
    const values = validValues();
    return Categories(graphqlClient).edit({
      id: categoryId,
      name: values.name
    });
  }

  function find(graphqlClient, params) {
    return Categories(graphqlClient).find(params);
  }

  function findOne(graphqlClient, discountId) {
    return Categories(graphqlClient).findOne(discountId);
  }

  function remove(graphqlClient, discountId) {
    return Categories(graphqlClient).remove(discountId);
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

export { CategoryModel };
