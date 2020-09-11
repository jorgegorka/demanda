<script>
  import FormButtons from "../../../../components/forms/buttons.svelte";
  import BasicFields from "./basic.svelte";
  import ContentFields from "./content.svelte";
  import ExtraFields from "./extra.svelte";

  export let product = {};
  export let categories = [];
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <BasicFields {product} {categories} />
    <ContentFields {product} />
    <ExtraFields {product} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
