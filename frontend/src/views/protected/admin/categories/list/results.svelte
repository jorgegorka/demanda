<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import CategoryItem from "./item.svelte";

  export let categories = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let categoryId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    categoryId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteCategory", categoryId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Subcategories</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each categories as category (category.id)}
      <CategoryItem {category} on:removeCategory={openModal} />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete category" />
