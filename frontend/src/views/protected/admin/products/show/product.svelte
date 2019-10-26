<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import ProductResults from "../results.svelte";
  import Translations from "../../../../components/protected/translations/index.svelte";

  export let product = {};
  export let graphqlClient;
</script>

<PageHeader title={product.name}>
  <div class="flex items-center">
    <a
      href={`/admin/translations/new/${product.id}`}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons ">add</i>
      Add Translation
    </a>
    <a
      href={`/admin/products/edit/${product.id}`}
      class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit product
    </a>
  </div>
</PageHeader>

<div class="mt-4">
  {#if product.translations.length > 0}
    <Translations translations={product.translations} />
  {:else}
    <Alert message="This product has no translations available." />
  {/if}
</div>
