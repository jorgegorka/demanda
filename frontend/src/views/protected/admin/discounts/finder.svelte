<script>
  import Loading from "../../../components/loading.svelte";
  import ShowDiscount from "./show/discount.svelte";
  import EditDiscount from "./edit/discount.svelte";
  import { DiscountModel } from "../../../../lib/models/discount";

  export let discountId;
  export let show = true;

  let discount = DiscountModel().findOne(discountId);

  $: discount = DiscountModel().findOne(discountId);
</script>

{#await $discount}
  <Loading />
{:then result}
  {#if show}
    <ShowDiscount discount={result.data.discounts[0]} />
  {:else}
    <EditDiscount discount={result.data.discounts[0]} categories={result.data.categories} />
  {/if}
{:catch error}
  Error: {error}
{/await}
