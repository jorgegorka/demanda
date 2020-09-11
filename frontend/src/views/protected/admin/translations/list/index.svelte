<script>
  import { createEventDispatcher } from "svelte";

  import Alert from "../../../../components/alert/index.svelte";
  import Results from "./results.svelte";
  import NewTranslation from "../new/index.svelte";
  import EditTranslation from "../edit/index.svelte";

  export let translations = [];
  export let parent = {};

  const dispatch = createEventDispatcher();
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
      .remove(translationInfo)
      .then(function (result) {
        if (result.errors.length === 0) {
          product.translations = product.translations.filter(
            (translation) => translation.id !== translationInfo.id
          );
        }
      });
  }
</script>

{#if translations.length > 0}
  <Results {translations} />
{:else}
  <Alert message="No translations">
    <a
      href="#!"
      on:click={addTranslation}
      class="whitespace-no-wrap font-medium text-blue-700 hover:text-blue-600
        transition ease-in-out duration-150">
      Add Translation
    </a>
  </Alert>
{/if}

{#if newTranslation}
  <NewTranslation
    {showModal}
    {parent}
    on:updateTranslation={updateTranslation} />
{:else}
  <EditTranslation
    {showModal}
    {parent}
    {translation}
    on:updateTranslation={updateTranslation} />
{/if}
