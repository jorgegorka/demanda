<script>
  import ShowCategory from "./category.svelte";
  import CategoryFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: categoryId = currentRoute.namedParams.id;
</script>

<CategoryFinder
  show={false}
  {categoryId}
  graphqlClient={params.graphqlClient} />
