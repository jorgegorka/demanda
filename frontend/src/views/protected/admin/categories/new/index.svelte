<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";
  import { categoryValidator } from "./validations";
  import { Categories } from "../../../../../lib/database/categories";

  export let currentRoute;
  export let params;

  const parentId = currentRoute.namedParams.parentId;
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
      const categoryInfo = {
        name: formFields.name.value,
        parentId: formFields.parentId.value
      };

      await Categories($apolloClient).add(categoryInfo);
      // await submitForm($apolloClient, formFields);
      disableAction = false;
      navigateTo("/admin/categories");
    } else {
      disableAction = false;
    }
  }
</script>

<PageHeader title="New category" />

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault={addCategory}>
    <TextInput
      bind:value={formFields.name.value}
      error={formFields.name.error}
      label="Name"
      isFocused={true}
      hintMessage={formFields.name.message} />
    <FormButtons
      cancelButton={false}
      submitText="Create category"
      isLoading={disableAction} />
  </form>
</div>
