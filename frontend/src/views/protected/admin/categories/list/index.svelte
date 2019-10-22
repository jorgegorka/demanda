<script>
  import Loading from "../../../../components/loading.svelte";
  import CategoryResults from "./results.svelte";
  import { Categories } from "../../../../../lib/database/categories";

  export let parentId;
  export let graphqlClient;

  const listParams = {};

  const categoriesList = Categories(graphqlClient).find(listParams);

  function deleteCategory(event) {
    Categories(graphqlClient)
      .remove(event.detail)
      .then(function(result) {
        if (result.errors.length === 0) {
          categoriesList.refetch();
        }
      });
  }
</script>

{#await $categoriesList}
  <Loading />
{:then result}
  <CategoryResults
    categories={result.data.categories}
    on:deleteCategory={deleteCategory} />
{:catch error}
  Error: {error}
{/await}
