<script>
  import FormFields from "./fields.svelte";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { Session } from "../../../../lib/database/session";
  import { LoginModel } from "../../../../lib/models/login";

  let loginModel = LoginModel({
    email: "",
    password: "",
  });

  async function loginUser() {
    if (loginModel.valid()) {
      await Session($apolloClient).add(loginModel.validValues());
    } else {
      loginModel = { ...loginModel };
    }
  }
</script>

<FormFields on:submit={loginUser} login={loginModel} />
