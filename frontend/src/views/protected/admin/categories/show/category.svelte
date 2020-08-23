<script>
  import { createEventDispatcher } from "svelte";

  import Header from "./header.svelte";
  import ListAttachments from "../../../../components/attachments/list.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import CategoryResults from "../results.svelte";
  import NewTranslation from "../../translations/new/index.svelte";
  import EditTranslation from "../../translations/edit/index.svelte";
  import TranslationResults from "../../translations/list/results.svelte";

  export let category = {};
  export let graphqlClient;

  const dispatch = createEventDispatcher();
  const parent = {
    id: category.id,
    type: "categories",
    name: category.name,
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
    dispatch("updateCategory");
  }

  function deleteTranslation(event) {
    const translationInfo = {
      id: event.detail,
      parentType: "categories",
      parentId: category.id,
    };
    TranslationModel()
      .remove(graphqlClient, translationInfo)
      .then(function (result) {
        if (result.errors.length === 0) {
          category.translations = category.translations.filter((translation) => translation.id !== translationInfo.id);
        }
      });
  }
</script>

<Header on:addTranslation={addTranslation} {category} />

<div class="mt-4">
  {#if category.attachments.length > 0}
    <ListAttachments attachments={category.attachments} {graphqlClient} />
  {:else}
    <Alert message="No attachments." />
  {/if}
</div>

<div class="mt-4">
  {#if category.translations.length > 0}
    <TranslationResults
      translations={category.translations}
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
