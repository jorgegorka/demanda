<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import CommentItem from "./item.svelte";

  export let comments = [];

  const dispatch = createEventDispatcher();

  let showModal = false;
  let commentId;

  function closeModal() {
    showModal = false;
  }

  function openModal(event) {
    commentId = event.detail;
    showModal = true;
  }

  function confirmDelete() {
    showModal = false;
    dispatch("deleteComment", commentId);
  }
</script>

<div class="bg-white shadow overflow-hidden sm:rounded-md">
  <ul>
    {#each comments as comment (comment.id)}
      <CommentItem {comment} on:removeComment={openModal} on:approveComment />
    {/each}
  </ul>
</div>

<Modal
  {showModal}
  title="Are you sure?"
  layerClosesForm={true}
  on:confirmModal={confirmDelete}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText="Delete comment" />
