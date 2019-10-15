<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { loginValidator } from "./validations";
  import { submitForm } from "./submit";

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

  console.log();

  async function loginUser() {
    disableAction = true;
    const validationResult = loginValidator(formFields);
    formFields = { ...validationResult.formFields };
    if (validationResult.valid) {
      await submitForm(graphqlClient, formFields);
      disableAction = false;
    } else {
      disableAction = false;
    }
  }

  $: graphqlClient = $apolloClient;
</script>

<FormFields on:submit={loginUser} {formFields} />
