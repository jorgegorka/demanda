<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { Session } from "../../../../lib/database/session";
  import { SignupModel } from "../../../../lib/models/signup";

  let disableAction = false;
  let signupModel = SignupModel({
    name: "",
    email: "",
    password: ""
  });

  async function signInUser() {
    disableAction = true;
    if (signupModel.valid()) {
      await Session($apolloClient).create(signupModel.validValues());
    } else {
      // reasign to be reactive
      signupModel = { ...signupModel };
    }
    disableAction = true;
  }
</script>

<FormFields on:submit={signInUser} signup={signupModel} />
