<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { submitForm } from "./submit";
  import { SignupModel } from "../../../../lib/models/signup";

  let disableAction = false;
  let graphqlClient = {};
  let signupModel = SignupModel({
    name: "",
    email: "",
    password: ""
  });

  async function signInUser() {
    disableAction = true;
    if (signupModel.valid()) {
      await submitForm(graphqlClient, signupModel.validValues());
    } else {
      // reasign to be reactive
      signupModel = { ...signupModel };
    }
    disableAction = true;
  }

  $: graphqlClient = $apolloClient;
</script>

<FormFields on:submit={signInUser} signup={signupModel} />
