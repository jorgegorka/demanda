<script>
  import Loading from "../../../components/loading.svelte";
  import ShowCategory from "./show/category.svelte";
  import EditCategory from "./edit/category.svelte";
  import { CategoryModel } from "../../../../lib/models/category";

  export let categoryId;
  export let show = true;

  let category = CategoryModel().findOne(categoryId);

  function reload() {
    category.refetch();
  }
</script>

{#await $category}
  <Loading />
{:then result}
  {#if show}
    <ShowCategory category={result.data.categories[0]} on:updateCategory={reload} />
  {:else}
    <EditCategory category={result.data.categories[0]} />
  {/if}
{:catch error}
  Error: {error}
{/await}
