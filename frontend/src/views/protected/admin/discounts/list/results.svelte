<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import DiscountItem from "./item.svelte";

  export let discounts = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let discountId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    discountId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteDiscount", discountId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Discount</th>
      <th class="p-4 text-right">Start at</th>
      <th class="p-4 text-right">End at</th>
      <th class="p-4 text-right">Active</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each discounts as discount (discount.id)}
      <DiscountItem {discount} on:removeDiscount={openModal} />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete discount" />
