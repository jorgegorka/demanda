import { FormValidator } from "../../../../lib/utils/form_validator";

const signupConstraints = {
  name: {
    presence: true,
    length: {
      minimum: 4,
      message: "must be at least 4 characters"
    }
  },
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

function signupValidator(formFields) {
  return FormValidator(formFields, signupConstraints).validateData();
}

export { signupValidator };
