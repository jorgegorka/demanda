<script>
  import ProductFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: productId = currentRoute.namedParams.id;
</script>

<ProductFinder {productId} graphqlClient={params.graphqlClient} />
