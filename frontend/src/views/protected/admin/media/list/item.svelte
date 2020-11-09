<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import ShowMediaItem from "../show/index.svelte";
  import { AttachmentModel } from "../../../../../lib/models/attachment";

  export let attachment = {};

  let showModal = false;

  const dispatch = createEventDispatcher();

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    event.preventDefault();
    showModal = true;
  }

  function confirmDelete() {
    AttachmentModel()
      .remove(attachment.id)
      .then(() => {
        showModal = false;
        window.location.reload();
      });
  }

  function languageName(language) {
    if (language) {
      return language.name;
    } else {
      return "All";
    }
  }
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">{attachment.title}</td>
  <td class="py-3 ">{languageName(attachment.language)}</td>
  <td class="py-3 ">
    <ShowMediaItem {attachment} name="thumb" />
  </td>
  <td class="py-3 ">{attachment.order}</td>
  <td class="py-3 pr-4 text-right">
    <a href="#!" class="ml-2" on:click={(e) => openModal(e)}>
      <svg
        viewBox="0 0 20 20"
        fill="currentColor"
        class="trash w-6 h-6 text-red-500">
        <path
          fill-rule="evenodd"
          d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0
          100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1
          1 0 00-1-1z"
          clip-rule="evenodd" />
      </svg>
    </a>
  </td>
</tr>

<Modal
  {showModal}
  title="Are you sure?"
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete media item" />
