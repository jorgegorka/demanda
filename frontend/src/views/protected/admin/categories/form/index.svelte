<script>
  import BasicFields from "./basic.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let category = {};
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <BasicFields {category} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
