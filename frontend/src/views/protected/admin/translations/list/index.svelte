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
    location.reload();
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
          location.reload();
        }
      });
  }
</script>

<div class="bg-white px-4 py-5 border-b border-gray-200 sm:px-6">
  <div
    class="-ml-4 -mt-2 flex items-center justify-between flex-wrap
      sm:flex-no-wrap">
    <div class="ml-4 mt-2">
      <h3 class="text-lg leading-6 font-medium text-gray-900">Content</h3>
    </div>
    <div class="ml-4 mt-2 flex-shrink-0">
      <a href="#!" on:click={addTranslation} class="btn-primary mr-8">
        <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
          <path
            fill-rule="evenodd"
            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
            clip-rule="evenodd" />
        </svg> Add Content
      </a>
    </div>
  </div>
</div>

{#if translations.length > 0}
  <Results
    {translations}
    on:editTranslation={editTranslation}
    on:deleteTranslation={deleteTranslation} />
{:else}
  <Alert message="No translations" />
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
