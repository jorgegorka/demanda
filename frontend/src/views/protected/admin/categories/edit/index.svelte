<script>
  import { query } from "svelte-apollo";

  import Loading from "../../../../components/loading.svelte";
  import ShowCategory from "./category.svelte";
  import { Categories } from "../../../../../lib/database/categories";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  export let currentRoute;
  export let params;
  let category = Categories($apolloClient).findOne(currentRoute.namedParams.id);

  $: category = Categories($apolloClient).findOne(currentRoute.namedParams.id);
</script>

{#await $category}
  <Loading />
{:then result}
  <ShowCategory category={result.data.categories[0]} />
{:catch error}
  Error: {error}
{/await}
