<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import TextInput from "../../../../components/forms/text_input.svelte";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";
  import { categoryValidator } from "./validations";
  import { submitForm } from "./submit";

  export let showModal = false;
  export let parentId;

  const dispatch = createEventDispatcher();
  let disableAction = false;
  let formFields = {
    name: {
      value: "",
      error: false,
      message: ""
    },
    parentId: {
      value: parentId
    }
  };

  async function addCategory() {
    disableAction = true;
    const validationResult = categoryValidator(formFields);
    formFields = { ...validationResult.formFields };
    if (validationResult.valid) {
      await submitForm($apolloClient, formFields);
      disableAction = false;
      dispatch("closeModal");
    } else {
      disableAction = false;
    }
  }
</script>

<Modal
  {showModal}
  {disableAction}
  title="New category"
  confirmText="Create category"
  on:closeModal
  on:cancelModal
  on:confirmModal={addCategory}>
  <TextInput
    bind:value={formFields.name.value}
    error={formFields.name.error}
    isFocused={true}
    hintMessage={formFields.name.message} />
</Modal>
