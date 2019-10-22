<script>
  import ShowCategory from "./tax.svelte";
  import CategoryFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: taxId = currentRoute.namedParams.id;
</script>

<CategoryFinder {taxId} graphqlClient={params.graphqlClient} />
