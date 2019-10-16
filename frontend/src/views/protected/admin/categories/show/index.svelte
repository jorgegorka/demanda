<script>
  import { query } from "svelte-apollo";

  import Loading from "../../../../components/loading.svelte";
  import ShowCategory from "./category.svelte";
  import { showCategory } from "../../../../../lib/queries/categories";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  export let currentRoute;
  export let params;

  const listParams = { parentId: currentRoute.namedParams.id };

  const categories = query($apolloClient, {
    query: showCategory,
    variables: listParams
  });
</script>

{#await $categories}
  <Loading />
{:then result}
  <ShowCategory category={result.data.categories[0]} />
{:catch error}
  Error: {error}
{/await}
