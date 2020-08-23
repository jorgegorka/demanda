<script>
  import { createEventDispatcher } from "svelte";

  import Alert from "../../../../components/alert/index.svelte";
  import AttachmentItem from "./item.svelte";
  import NewAttachment from "../new/index.svelte";

  export let attachments = [];
  export let parent = {};

  const dispatch = createEventDispatcher();
  let showModal = false;
  let attachmentId;
  let attachment = {};

  function addAttachment() {
    showModal = true;
  }
</script>

{#if attachments.length > 0}
  <div class="bg-white px-4 py-5 border-b border-gray-200 sm:px-6">
    <div class="-ml-4 -mt-2 flex items-center justify-between flex-wrap sm:flex-no-wrap">
      <div class="ml-4 mt-2">
        <h3 class="text-lg leading-6 font-medium text-gray-900">Attachments</h3>
      </div>
      <div class="ml-4 mt-2 flex-shrink-0">
        <a href="#!" on:click={addAttachment} class="btn-primary mr-8">
          <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
            <path
              fill-rule="evenodd"
              d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
              clip-rule="evenodd" />
          </svg>
          Add Media content
        </a>
      </div>
    </div>
  </div>
  <table class="bg-white w-full rounded">
    <thead class="">
      <tr class="text-gray-700 bg-gray-100">
        <th class="p-4 text-left">Media</th>
        <th class=" text-left">Language</th>
        <th class=" text-left">URL</th>
        <th class=" text-left">Order</th>
        <th class="p-4 text-right">Options</th>
      </tr>
    </thead>
    <tbody>
      {#each attachments as attachment (attachment.id)}
        <AttachmentItem {attachment} />
      {/each}
    </tbody>
  </table>
{:else}
  <Alert message="No media available.">
    <a
      href="#!"
      on:click={addAttachment}
      class="whitespace-no-wrap font-medium text-blue-700 hover:text-blue-600 transition ease-in-out duration-150">
      Add Media content
    </a>
  </Alert>
{/if}

<NewAttachment {showModal} {parent} />
