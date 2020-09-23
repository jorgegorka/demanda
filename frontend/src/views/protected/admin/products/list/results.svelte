<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import ProductItem from "./item.svelte";

  export let products = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let productId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    productId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteProduct", productId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Category</th>
      <th class="p-4 text-right">Tags</th>
      <th class="p-4 text-right">Price</th>
      <th class="p-4 text-right">Stock</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each products as product (product.id)}
      <ProductItem {product} on:removeProduct={openModal} />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete product" />
