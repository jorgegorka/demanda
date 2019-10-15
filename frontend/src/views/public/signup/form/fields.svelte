<script>
  import TextInput from "../../../components/forms/text_input.svelte";
  import PasswordInput from "../../../components/forms/password_input.svelte";
  import EmailInput from "../../../components/forms/email_input.svelte";
  import FormButtons from "../../../components/forms/buttons.svelte";

  export let email = {};
  export let password = {};
  export let name = {};
  export let disableAction = false;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault>
  <TextInput
    bind:value={name.value}
    error={name.error}
    label="Your name"
    icon="person"
    isFocused={true}
    hintMessage={name.message} />
  <EmailInput
    bind:value={email.value}
    error={email.error}
    hintMessage={email.message} />
  <PasswordInput
    bind:value={password.value}
    error={password.error}
    label="Password"
    hintMessage={password.message} />
  <FormButtons
    cancelButton={false}
    submitText="Create account"
    isLoading={disableAction} />
</form>
