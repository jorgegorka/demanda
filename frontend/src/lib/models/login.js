import { ValidationModel } from "./validation";

function LoginModel(login) {
  const constraints = {
    email: {
      presence: true,
      email: true
    },
    password: {
      presence: true,
      length: {
        minimum: 8,
        message: "must be at least 8 characters"
      }
    }
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
    validValues
  });
}

export { LoginModel };
