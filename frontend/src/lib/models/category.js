import { ValidationModel } from "./validation";
import { Categories } from "../database/categories";

function CategoryModel(category = {}) {
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

  const validation = ValidationModel(category, constraints);
  const fields = validation.fields();

  function add() {
    return Categories().add(validValues());
  }

  function edit(categoryId) {
    return Categories().edit({
      ...validValues(),
      id: categoryId,
    });
  }

  function find(params) {
    return Categories().find(params);
  }

  function findOne(categoryId) {
    return Categories().findOne(categoryId);
  }

  function remove(categoryId) {
    return Categories().remove(categoryId);
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

export { CategoryModel };
