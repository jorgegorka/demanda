<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let category = {};
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <TextInput
      bind:value={category.fields.name.value}
      error={category.fields.name.error}
      label="Name"
      isFocused={true}
      hintMessage={category.fields.name.message} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
