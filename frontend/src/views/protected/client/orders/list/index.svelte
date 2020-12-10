<script>
  import Loading from "../../../../components/loading.svelte";
  import OrderResults from "./results.svelte";
  import { Order } from "../../../../../lib/models/order";

  const listParams = {};

  const ordersList = Order().find(listParams);
</script>

{#await $ordersList}
  <Loading />
{:then result}
  <OrderResults orders={result.data.orders} />
{:catch error}
  Error:
  {error}
{/await}
