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

<div class="bg-white px-4 py-5 border-b border-gray-200 sm:px-6">
  <div class="-ml-4 -mt-2 flex items-center justify-between flex-wrap sm:flex-no-wrap">
    <div class="ml-4 mt-2">
      <h3 class="text-lg leading-6 font-medium text-gray-900">Translations</h3>
    </div>
    <div class="ml-4 mt-2 flex-shrink-0">
      <a href="#!" class="btn-primary mr-8">
        <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
          <path
            fill-rule="evenodd"
            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
            clip-rule="evenodd" />
        </svg>
        Add Translation
      </a>
    </div>
  </div>
</div>
<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class=" text-left">Language</th>
      <th class="p-4 text-left">Text</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each translations as translation (translation.id)}
      <TranslationItem {translation} on:removeTranslation={openModal} on:editTranslation />
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
