<script>
  import Loading from "../../../components/loading.svelte";
  import ShowDiscount from "./show/discount.svelte";
  import EditDiscount from "./edit/discount.svelte";
  import { Discounts } from "../../../../lib/database/discounts";

  export let discountId;
  export let graphqlClient;
  export let show = true;

  let discount = Discounts(graphqlClient).findOne(discountId);

  $: discount = Discounts(graphqlClient).findOne(discountId);
</script>

{#await $discount}
  <Loading />
{:then result}
  {#if show}
    <ShowDiscount discount={result.data.discounts[0]} {graphqlClient} />
  {:else}
    <EditDiscount
      discount={result.data.discounts[0]}
      categories={result.data.categories}
      {graphqlClient} />
  {/if}
{:catch error}
  Error: {error}
{/await}
