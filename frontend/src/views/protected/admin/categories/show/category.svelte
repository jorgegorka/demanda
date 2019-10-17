<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import CategoryResults from "../list/results.svelte";
  import Translations from "../../../../components/protected/translations/index.svelte";

  export let category = {};
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
  <CategoryResults categories={category.children} />
{:else}
  <Alert message="This category has no children categories">
    <a
      href={`/admin/categories/new/${category.id}`}
      class="btn primary flex align-middle">
      <i class="material-icons ">add</i>
      Add children category
    </a>
  </Alert>
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
