<script>
  import { createEventDispatcher } from "svelte";

  import PageHeader from "../../../../components/protected/page_header.svelte";
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
    name: category.name
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
      parentId: category.id
    };
    TranslationModel()
      .remove(graphqlClient, translationInfo)
      .then(function(result) {
        if (result.errors.length === 0) {
          category.translations = category.translations.filter(
            translation => translation.id !== translationInfo.id
          );
        }
      });
  }
</script>

<PageHeader title={category.name}>
  <div class="flex items-center">
    {#if category.parent}
      <a
        href={`/admin/categories/show/${category.parent.id}`}
        class="text-link mr-8">
        Back to {category.parent.name}
      </a>
    {/if}
    <a
      href="#!"
      on:click={addTranslation}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons ">add</i>
      Add Translation
    </a>
    <a
      href={`/admin/categories/new/${category.id}`}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons ">add</i>
      Add children category
    </a>
    <a
      href={`/admin/categories/edit/${category.id}`}
      class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit category
    </a>
  </div>
</PageHeader>

{#if category.children.length > 0}
  <CategoryResults categories={category.children} {graphqlClient} />
{:else}
  <Alert message="This category has no children categories" />
{/if}

<div class="mt-4">
  {#if category.translations.length > 0}
    <TranslationResults
      translations={category.translations}
      on:editTranslation={editTranslation}
      on:deleteTranslation={deleteTranslation} />
  {:else}
    <Alert message="This category has no translations available." />
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
