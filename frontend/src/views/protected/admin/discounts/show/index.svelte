<script>
  import DiscountFinder from "../finder.svelte";

  export let currentRoute;

  $: discountId = currentRoute.namedParams.id;
</script>

<DiscountFinder {discountId} />
