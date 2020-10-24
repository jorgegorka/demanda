<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import AddressItem from "./item.svelte";

  export let addresses = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let addressId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    addressId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteAddress", addressId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-left">Address</th>
      <th class="p-4 text-left">Postal Code</th>
      <th class="p-4 text-left">City</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each addresses as address (address.id)}
      <AddressItem {address} on:removeAddress={openModal} />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete address" />
