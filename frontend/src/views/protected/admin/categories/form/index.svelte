<script>
  import { createEventDispatcher } from "svelte";

  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let category = {};
  export let submitText = "";
  export let disableAction = false;

  const dispatch = createEventDispatcher();
  let formFields = category.fields();

  function submitCategory() {
    const { fieldsInfo, valid } = category.valid(formFields);
    formFields = { ...fieldsInfo };

    if (valid) {
      dispatch("validInfo", category.validValues(formFields));
    }
  }
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault={submitCategory}>
    <TextInput
      bind:value={formFields.name.value}
      error={formFields.name.error}
      label="Name"
      isFocused={true}
      hintMessage={formFields.name.message} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
