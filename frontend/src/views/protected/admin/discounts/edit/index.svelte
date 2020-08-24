<script>
  import ShowDiscount from "./discount.svelte";
  import DiscountFinder from "../finder.svelte";

  export let currentRoute;

  $: discountId = currentRoute.namedParams.id;
</script>

<DiscountFinder show={false} {discountId} />
