<script>
  import BasicFields from "./fields.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let user = {};
  export let submitText = "";
  export let disableAction = false;
</script>

<form class="p-4" ref="form" on:submit|preventDefault>
  <BasicFields {user} />
  <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
</form>
