<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import TranslationItem from "./item.svelte";

  export let translations = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let translationId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    translationId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteTranslation", translationId);
  }
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Language</th>
      <th class="p-4 text-left">Text</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each translations as translation (translation.id)}
      <TranslationItem
        {translation}
        on:removeTranslation={openModal}
        on:editTranslation />
    {/each}
  </tbody>
</table>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete translation" />
