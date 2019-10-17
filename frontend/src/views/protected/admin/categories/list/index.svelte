<script>
  import { query } from "svelte-apollo";

  import Loading from "../../../../components/loading.svelte";
  import CategoryResults from "./results.svelte";
  import { Request } from "../../../../../lib/queries/request";
  import {
    listCategories,
    deleteCategory
  } from "../../../../../lib/queries/categories";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  export let parentId;

  const listParams = {};

  const categories = query($apolloClient, {
    query: listCategories,
    variables: listParams
  });

  function removeCategory(event) {
    const categoryInfo = { id: event.detail };
    Request.mutation(
      $apolloClient,
      "deleteCategory",
      {
        mutation: deleteCategory,
        variables: { categoryInfo }
      },
      { success: "Category deleted successfully" }
    ).then(function() {
      categories.refetch();
    });
  }
</script>

{#await $categories}
  <Loading />
{:then result}
  <CategoryResults
    categories={result.data.categories}
    on:removeCategory={removeCategory} />
{:catch error}
  Error: {error}
{/await}
