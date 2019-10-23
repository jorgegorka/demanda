<script>
  import ShowDiscount from "./discount.svelte";
  import DiscountFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: discountId = currentRoute.namedParams.id;
</script>

<DiscountFinder
  show={false}
  {discountId}
  graphqlClient={params.graphqlClient} />
