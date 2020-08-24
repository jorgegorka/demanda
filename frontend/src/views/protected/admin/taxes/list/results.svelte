<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import TaxItem from "./item.svelte";

  export let taxes = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let taxId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    taxId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteTax", taxId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Tax</th>
      <th class="p-4 text-right">Start at</th>
      <th class="p-4 text-right">End at</th>
      <th class="p-4 text-right">Active</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each taxes as tax (tax.id)}
      <TaxItem {tax} on:removeTax={openModal} />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete tax" />
