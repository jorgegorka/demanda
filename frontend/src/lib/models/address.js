import { ValidationModel } from "./validation";
import { AddressQuery } from "../database/address";

function Address(address = {}) {
  const constraints = {
    name: {
      presence: false,
      type: "string",
    },
    firstAddress: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter an address.",
      },
    },
    secondAddress: {
      presence: false,
      type: "string",
    },
    postalCode: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a postal code.",
      },
    },
    city: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a city.",
      },
    },
    country: {
      presence: true,
      type: "string",
    },
  };

  const validation = ValidationModel(address, constraints);
  const fields = validation.fields();

  function add() {
    return AddressQuery().add(validValues());
  }

  function edit(addressId) {
    return AddressQuery().edit({
      ...validValues(),
      id: addressId,
    });
  }

  function find(params) {
    return AddressQuery().find(params);
  }

  function findOne(addressId) {
    return AddressQuery().findOne(addressId);
  }

  function remove(addressId) {
    return AddressQuery().remove(addressId);
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

export { Address };
