<script>
  import Loading from "../../../../components/loading.svelte";
  import CategoryResults from "./results.svelte";
  import { Categories } from "../../../../../lib/database/categories";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  export let parentId;

  const listParams = {};

  const categoriesList = Categories($apolloClient).find(listParams);

  function removeCategory(event) {
    Categories($apolloClient)
      .remove(event.detail)
      .then(function() {
        categoriesList.refetch();
      });
  }
</script>

{#await $categoriesList}
  <Loading />
{:then result}
  <CategoryResults
    categories={result.data.categories}
    on:removeCategory={removeCategory} />
{:catch error}
  Error: {error}
{/await}
