<script>
  import PasswordInput from "../../../components/forms/password_input.svelte";
  import EmailInput from "../../../components/forms/email_input.svelte";
  import FormButtons from "../../../components/forms/buttons.svelte";

  export let login = {};
  export let disableAction = false;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault>
  <EmailInput
    bind:value={login.fields.email.value}
    error={login.fields.email.error}
    focused={true}
    hintMessage={login.fields.email.message} />
  <PasswordInput
    bind:value={login.fields.password.value}
    error={login.fields.password.error}
    hintMessage={login.fields.password.message} />
  <FormButtons
    cancelButton={false}
    submitText="Login"
    isLoading={disableAction} />
</form>
