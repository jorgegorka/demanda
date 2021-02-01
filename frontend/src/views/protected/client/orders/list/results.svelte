<script>
  import OrderItem from "./item.svelte";

  export let orders = [];
</script>

{#each orders as order (order.id)}
  <OrderItem {order} />
{/each}
