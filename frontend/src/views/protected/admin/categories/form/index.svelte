<script>
  import { createEventDispatcher } from "svelte";

  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  import { categoryValidator } from "./validations";

  export let formFields = {};
  export let submitText = "";
  export let disableAction = false;

  const dispatch = createEventDispatcher();

  function submitCategory() {
    const validationResult = categoryValidator(formFields);
    formFields = { ...validationResult.formFields };
    if (validationResult.valid) {
      const categoryInfo = {
        name: formFields.name.value,
        parentId: formFields.parentId.value
      };
      dispatch("validInfo", categoryInfo);
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
