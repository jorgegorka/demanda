import { FormValidator } from "../../../../lib/utils/form_validator";

const loginConstraints = {
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

function loginValidator(formFields) {
  return FormValidator(formFields, loginConstraints).validateData();
}

export { loginValidator };
