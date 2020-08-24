<script>
  import CategoryFinder from "../finder.svelte";

  export let currentRoute;

  $: categoryId = currentRoute.namedParams.id;
</script>

<CategoryFinder show={false} {categoryId} />
