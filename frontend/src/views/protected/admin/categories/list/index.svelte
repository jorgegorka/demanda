<script>
  import { query } from "svelte-apollo";

  import Loading from "../../../../components/loading.svelte";
  import { listCategories } from "../../../../../lib/queries/categories";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  const categories = query($apolloClient, { query: listCategories });
</script>

<h1 class="text-2xl font-display">Categories</h1>

{#await $categories}
  <Loading />
{:then result}
  {#each result.data.categories as category}
    <p>{category.name}</p>
  {/each}
{:catch error}
  Error: {error}
{/await}
