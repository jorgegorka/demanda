<script>
  import { createEventDispatcher } from "svelte";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import ProductDetails from "./details.svelte";
  import TranslationResults from "../../translations/list/results.svelte";
  import MediaList from "../../media/list/index.svelte";
  import NewTranslation from "../../translations/new/index.svelte";
  import EditTranslation from "../../translations/edit/index.svelte";
  import { TranslationModel } from "../../../../../lib/models/translation";

  export let product = {};
  export let graphqlClient;

  const dispatch = createEventDispatcher();
  const parent = {
    id: product.id,
    type: "products",
    name: product.name,
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
      parentId: product.id,
    };
    TranslationModel()
      .remove(graphqlClient, translationInfo)
      .then(function (result) {
        if (result.errors.length === 0) {
          product.translations = product.translations.filter((translation) => translation.id !== translationInfo.id);
        }
      });
  }
</script>

<PageHeader title={product.name}>
  <div class="flex items-center">
    <a href={`/admin/products/edit/${product.id}`} class="btn-secondary">
      <svg viewBox="0 0 20 20" fill="currentColor" class="pencil w-6 h-6">
        <path
          d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3
          14.172V17h2.828l8.38-8.379-2.83-2.828z" />
      </svg>
      Edit product
    </a>
  </div>
</PageHeader>

<ProductDetails {product} />

<div class="mt-4">
  <MediaList attachments={product.attachments} {parent} />
</div>

<div class="mt-4">
  {#if product.translations.length > 0}
    <TranslationResults
      translations={product.translations}
      on:editTranslation={editTranslation}
      on:deleteTranslation={deleteTranslation} />
  {:else}
    <Alert message="No translations available." />
  {/if}
</div>

{#if newTranslation}
  <NewTranslation {showModal} {graphqlClient} {parent} on:updateTranslation={updateTranslation} />
{:else}
  <EditTranslation {showModal} {graphqlClient} {parent} {translation} on:updateTranslation={updateTranslation} />
{/if}
