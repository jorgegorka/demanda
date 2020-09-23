<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let language = {};
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <TextInput
      bind:value={language.fields.name.value}
      error={language.fields.name.error}
      label="Name"
      focused={true}
      hintMessage={language.fields.name.message} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
