<script>
  import { onMount } from "svelte";
  import { navigateTo } from "svelte-router-spa";
  import { query } from "svelte-apollo";
  import gql from "graphql-tag";
  import validate from "validate.js";

  import TextInput from "../../components/forms/text_input.svelte";
  import PasswordInput from "../../components/forms/password_input.svelte";
  import EmailInput from "../../components/forms/email_input.svelte";
  import FormButtons from "../../components/forms/buttons.svelte";
  import { notificationMessage } from "../../../lib/stores/notification_message.js";
  import { apolloClient } from "../../../lib/stores/apollo_client";

  const GET_BOOKS = gql`
    query {
      categories {
        id
        name
        parent {
          id
          name
        }
      }
    }
  `;

  const signupConstraints = {
    name: {
      presence: true,
      length: {
        minimum: 4,
        message: "must be at least 4 characters"
      }
    },
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

  let name = "";
  let nameError = false;
  let nameMessage = "";
  let email = "";
  let emailError = false;
  let emailMessage = "";
  let passwordMessage = "Min. 8 characters";
  let password = "";
  let passwordError = false;
  let disableAction = false;
  let graphqlClient = {};

  function resetErrorInfo() {
    let nameError = false;
    let nameMessage = "";
    let emailError = false;
    let emailMessage = "";
    let passwordMessage = "";
    let passwordError = false;
  }

  function validateLoginForm() {
    resetErrorInfo();
    const validationResult = validate(
      { name, email, password },
      signupConstraints
    );
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
      if (validationResult.name && validationResult.name.length > 0) {
        nameMessage = validationResult.name[0];
        nameError = true;
      }
    }

    return false;
  }

  async function signInUser() {
    const books = query(graphqlClient, { query: GET_BOOKS });
    disableAction = true;
    validateLoginForm();
    if (validateLoginForm()) {
      books.subscribe(async function(response) {
        const result = await response;
        notificationMessage.add({
          message: "Your account was created successfully. Please log in",
          type: "success-toast"
        });
        console.log(result.data);

        // notificationMessage.add({
        //   message: error.message,
        //   type: "danger-toast"
        // });
        // console.log(error);
        disableAction = false;
      });
    } else {
      disableAction = false;
    }
  }

  $: graphqlClient = $apolloClient;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault={signInUser}>
  <TextInput
    bind:value={name}
    error={nameError}
    label="Your name"
    icon="person"
    isFocused={true}
    hintMessage={nameMessage} />
  <EmailInput
    bind:value={email}
    error={emailError}
    hintMessage={emailMessage} />
  <PasswordInput
    bind:value={password}
    error={passwordError}
    label="Password"
    hintMessage={passwordMessage} />
  <FormButtons
    cancelButton={false}
    submitText="Create account"
    isLoading={disableAction} />
</form>
