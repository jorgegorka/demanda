<script>
  import { createEventDispatcher } from "svelte";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import ProductResults from "../results.svelte";
  import ProductDetails from "./details.svelte";
  import TranslationResults from "../../translations/list/results.svelte";
  import NewTranslation from "../../translations/new/index.svelte";
  import EditTranslation from "../../translations/edit/index.svelte";
  import { TranslationModel } from "../../../../../lib/models/translation";
  import { ProductModel } from "../../../../../lib/models/product";

  export let product = {};
  export let graphqlClient;

  const dispatch = createEventDispatcher();
  const parent = {
    id: product.id,
    type: "products",
    name: product.name
  };

  let showModal = false;
  let newTranslation = true;
  let translation = {};

  function editTranslation(event) {
    translation = event.detail;
    newTranslation = false;
    showModal = true;
  }

  function addTranslation() {
    showModal = true;
    newTranslation = true;
  }

  function updateTranslation() {
    showModal = false;
    dispatch("updateProduct");
  }

  function deleteTranslation(event) {
    const translationInfo = {
      id: event.detail,
      parentType: "products",
      parentId: product.id
    };
    TranslationModel()
      .remove(graphqlClient, translationInfo)
      .then(function(result) {
        if (result.errors.length === 0) {
          product.translations = product.translations.filter(
            translation => translation.id !== translationInfo.id
          );
        }
      });
  }
</script>

<PageHeader title={product.name}>
  <div class="flex items-center">
    <a
      href="#!"
      on:click={addTranslation}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons text- ">add</i>
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

<ProductDetails {product} />

<div class="mt-4">
  {#if product.translations.length > 0}
    <TranslationResults
      translations={product.translations}
      on:editTranslation={editTranslation}
      on:deleteTranslation={deleteTranslation} />
  {:else}
    <Alert message="This product has no translations available." />
  {/if}
</div>

{#if newTranslation}
  <NewTranslation
    {showModal}
    {graphqlClient}
    {parent}
    on:updateTranslation={updateTranslation} />
{:else}
  <EditTranslation
    {showModal}
    {graphqlClient}
    {parent}
    {translation}
    on:updateTranslation={updateTranslation} />
{/if}
