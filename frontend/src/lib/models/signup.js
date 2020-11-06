import { ValidationModel } from "./validation";

function SignupModel(login = {}) {
  const constraints = {
    name: {
      presence: true,
      length: {
        minimum: 4,
        message: "must be at least 4 characters",
      },
    },
    email: {
      presence: true,
      email: true,
      message: "must be a valid email address",
    },
    password: {
      presence: true,
      length: {
        minimum: 8,
        message: "must be at least 8 characters",
      },
    },
  };

  const validation = ValidationModel(login, constraints);
  const fields = validation.fields();

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    fields,
    valid,
    validValues,
  });
}

export { SignupModel };
