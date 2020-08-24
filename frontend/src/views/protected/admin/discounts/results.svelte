<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { Discounts } from "../../../../lib/database/discounts";

  export let discounts;

  function deleteDiscount(event) {
    Discounts()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          discounts = discounts.filter((discount) => discount.id !== event.detail);
        }
      });
  }
</script>

<ListResults {discounts} on:deleteDiscount={deleteDiscount} />
