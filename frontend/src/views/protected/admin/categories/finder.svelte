<script>
  import Loading from "../../../components/loading.svelte";
  import ShowCategory from "./show/category.svelte";
  import EditCategory from "./edit/category.svelte";
  import { Categories } from "../../../../lib/database/categories";

  export let categoryId;
  export let graphqlClient;
  export let show = true;

  let category = Categories(graphqlClient).findOne(categoryId);

  $: category = Categories(graphqlClient).findOne(categoryId);
</script>

{#await $category}
  <Loading />
{:then result}
  {#if show}
    <ShowCategory category={result.data.categories[0]} {graphqlClient} />
  {:else}
    <EditCategory category={result.data.categories[0]} {graphqlClient} />
  {/if}
{:catch error}
  Error: {error}
{/await}
