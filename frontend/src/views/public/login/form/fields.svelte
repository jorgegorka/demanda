<script>
  import PasswordInput from "../../../components/forms/password_input.svelte";
  import EmailInput from "../../../components/forms/email_input.svelte";
  import FormButtons from "../../../components/forms/buttons.svelte";

  export let formFields = {};
  export let disableAction = false;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault>
  <EmailInput
    bind:value={formFields.email.value}
    error={formFields.email.error}
    isFocused={true}
    hintMessage={formFields.email.message} />
  <PasswordInput
    bind:value={formFields.password.value}
    error={formFields.password.error}
    hintMessage={formFields.password.message} />
  <FormButtons
    cancelButton={false}
    submitText="Login"
    isLoading={disableAction} />
</form>
