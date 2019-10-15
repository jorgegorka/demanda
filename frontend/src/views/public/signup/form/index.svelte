<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { signupValidator } from "./validations";
  import { submitForm } from "./submit";

  let formFields = {
    name: {
      value: "",
      message: "",
      error: false
    },
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
  let graphqlClient = {};

  async function signInUser() {
    disableAction = true;
    const validationResult = signupValidator(formFields);
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

<FormFields on:submit={signInUser} {formFields} />
