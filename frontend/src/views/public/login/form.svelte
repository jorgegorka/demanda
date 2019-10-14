<script>
  import { navigateTo } from "svelte-router-spa";
  import { mutate } from "svelte-apollo";
  import validate from "validate.js";

  import TextInput from "../../components/forms/text_input.svelte";
  import PasswordInput from "../../components/forms/password_input.svelte";
  import EmailInput from "../../components/forms/email_input.svelte";
  import FormButtons from "../../components/forms/buttons.svelte";
  import { notificationMessage } from "../../../lib/stores/notification_message.js";
  import { apolloClient } from "../../../lib/stores/apollo_client";
  import { newSession } from "../../../lib/queries/session";
  import { SessionToken } from "../../../lib/session/token";

  const loginConstraints = {
    email: {
      presence: true,
      email: true
    },
    password: {
      presence: true,
      length: {
        minimum: 6,
        message: "must be at least 6 characters"
      }
    }
  };

  let email = "";
  let emailError = false;
  let emailMessage = "";
  let passwordMessage = "";
  let password = "";
  let passwordError = false;
  let disableAction = false;

  function resetErrorInfo() {
    let emailError = false;
    let emailMessage = "";
    let passwordMessage = "";
    let passwordError = false;
  }

  function validateLoginForm() {
    resetErrorInfo();
    const validationResult = validate({ email, password }, loginConstraints);
    if (!validationResult) {
      return true;
    } else {
      if (validationResult.email && validationResult.email.length > 0) {
        emailMessage = validationResult.email[0];
        emailError = true;
      }
      if (validationResult.password && validationResult.password.length > 0) {
        passwordMessage = validationResult.password[0];
        passwordError = true;
      }
    }

    return false;
  }

  async function signInUser() {
    disableAction = true;
    if (validateLoginForm()) {
      const loginInfo = { email, password };

      const response = await mutate(graphqlClient, {
        mutation: newSession,
        variables: { loginInfo }
      });
      const loginData = response.data.login;
      if (loginData.errors.length > 0) {
        notificationMessage.add({
          message: loginData.errors[0],
          type: "danger-msg"
        });
        emailError = true;
        passwordError = true;
      } else {
        notificationMessage.add({
          message: "Welcome back!",
          type: "success-msg"
        });
        SessionToken.create(loginData.token);
        // navigateTo("admin");
      }
      disableAction = false;

      // disableAction = false
    } else {
      disableAction = false;
    }
  }

  $: graphqlClient = $apolloClient;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault={signInUser}>
  <EmailInput
    bind:value={email}
    error={emailError}
    isFocused={true}
    hintMessage={emailMessage} />
  <PasswordInput
    bind:value={password}
    error={passwordError}
    hintMessage={passwordMessage} />
  <FormButtons
    cancelButton={false}
    submitText="Login"
    isLoading={disableAction} />
</form>
