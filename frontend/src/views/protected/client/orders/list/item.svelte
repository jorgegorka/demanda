<script>
  import OrderItem from "./order_item.svelte";

  export let order = {};
</script>

<div class="mb-4 bg-white shadow overflow-hidden sm:rounded-md">
  <div class="p-4 flex justify-between">
    <div>
      <span
        class="inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium bg-purple-100 text-purple-800">
        {order.status}
      </span>
    </div>
    <div class="flex">
      <p class="px-4">Total: {order.total}</p>
      <p>Total paid: {order.totalPaid}</p>
    </div>
  </div>
  <ul class="p-4 flex flex-col">
    {#each order.orderItems as item}
      <OrderItem {item} />
    {/each}
  </ul>
</div>
