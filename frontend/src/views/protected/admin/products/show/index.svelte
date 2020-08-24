<script>
  import ProductFinder from "../finder.svelte";

  export let currentRoute;

  $: productId = currentRoute.namedParams.id;
</script>

<ProductFinder {productId} />
