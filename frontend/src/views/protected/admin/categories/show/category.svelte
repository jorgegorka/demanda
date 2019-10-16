<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import CategoryResults from "../list/results.svelte";
  import Translations from "../../../../components/protected/translations/index.svelte";

  export let category = {};
</script>

<PageHeader title={category.name}>
  <a href="/admin/categories/edit/" class="btn primary flex align-middle">
    <i class="material-icons ">edit</i>
    Edit category
  </a>
</PageHeader>

{#if category.children.length > 0}
  <CategoryResults categories={category.children} />
{:else}
  <p>This category has no children categories</p>
{/if}

<div class="mt-4">
  {#if category.translations.length > 0}
    <Translations translations={category.translations} />
  {:else}
    <Alert message="This category has no aditional languages.">
      <a
        href={`/admin/translations/new/${category.id}`}
        class="btn primary flex align-middle">
        <i class="material-icons ">add</i>
        Add Translation
      </a>
    </Alert>
  {/if}
</div>
