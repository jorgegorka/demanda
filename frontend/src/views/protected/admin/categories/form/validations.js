import { FormValidator } from "../../../../../lib/utils/form_validator";

const categoryConstraints = {
  name: {
    presence: true,
    length: {
      minimum: 1,
      message: "Please enter a name."
    }
  },
  parentId: {
    presence: false
  }
};

function categoryValidator(formFields) {
  return FormValidator(formFields, categoryConstraints).validateData();
}

export { categoryValidator };
