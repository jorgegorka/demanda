<script>
  import TextInput from "../../../components/forms/text_input.svelte";
  import PasswordInput from "../../../components/forms/password_input.svelte";
  import EmailInput from "../../../components/forms/email_input.svelte";
  import FormButtons from "../../../components/forms/buttons.svelte";

  export let signup = {};
  export let disableAction = false;
</script>

<form class="px-10 py-4" ref="form" on:submit|preventDefault>
  <TextInput
    bind:value={signup.fields.name.value}
    error={signup.fields.name.error}
    label="Your name"
    icon="person"
    focused={true}
    hintMessage={signup.fields.name.message} />
  <EmailInput
    bind:value={signup.fields.email.value}
    error={signup.fields.email.error}
    hintMessage={signup.fields.email.message} />
  <PasswordInput
    bind:value={signup.fields.password.value}
    error={signup.fields.password.error}
    label="Password"
    hintMessage={signup.fields.password.message} />
  <FormButtons
    cancelButton={false}
    submitText="Create account"
    isLoading={disableAction} />
</form>
