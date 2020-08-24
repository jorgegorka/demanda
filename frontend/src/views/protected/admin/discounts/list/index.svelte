<script>
  import Loading from "../../../../components/loading.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import DiscountResults from "./results.svelte";
  import { DiscountModel } from "../../../../../lib/models/discount";

  const listParams = {};
  const discountModel = DiscountModel();

  const discountsList = discountModel.find(listParams);

  function deleteDiscount(event) {
    discountModel.remove(event.detail).then(function (result) {
      if (result.errors.length === 0) {
        discountsList.refetch();
      }
    });
  }
</script>

{#await $discountsList}
  <Loading />
{:then result}
  {#if result.data.discounts.length > 0}
    <DiscountResults discounts={result.data.discounts} on:deleteDiscount={deleteDiscount} />
  {:else}
    <Alert
      message="There are no discounts"
      extraInfo="You can be the lucky one that creates the first discount ever!" />
  {/if}
{:catch error}
  Error: {error}
{/await}
