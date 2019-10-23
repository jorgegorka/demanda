<script>
  import DiscountFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: discountId = currentRoute.namedParams.id;
</script>

<DiscountFinder {discountId} graphqlClient={params.graphqlClient} />
