<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { Session } from "../../../../lib/database/session";
  import { LoginModel } from "../../../../lib/models/login";

  let loginModel = LoginModel({
    email: "",
    password: ""
  });
  let disableAction = false;

  async function loginUser() {
    disableAction = true;
    if (loginModel.valid()) {
      await Session($apolloClient).add(loginModel.validValues());
    } else {
      // reasign to be reactive
      loginModel = { ...loginModel };
    }
    disableAction = true;
  }
</script>

<FormFields on:submit={loginUser} login={loginModel} />
