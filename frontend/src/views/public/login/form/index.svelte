<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { Session } from "../../../../lib/database/session";
  import { loginValidator } from "./validations";

  let formFields = {
    email: {
      value: "",
      message: "",
      error: false
    },
    password: {
      value: "",
      message: "Min. 8 characters",
      error: false
    }
  };
  let disableAction = false;

  async function loginUser() {
    disableAction = true;
    const validationResult = loginValidator(formFields);
    formFields = { ...validationResult.formFields };
    if (validationResult.valid) {
      const loginInfo = {
        email: formFields.email.value,
        password: formFields.password.value
      };
      await Session($apolloClient).add(loginInfo);

      disableAction = false;
    } else {
      disableAction = false;
    }
  }
</script>

<FormFields on:submit={loginUser} {formFields} />
