<script>
  import { createEventDispatcher } from "svelte";

  import Alert from "../../../../components/alert/index.svelte";
  import ResultsHeader from "./results_header.svelte";
  import Results from "./results.svelte";
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
  <ResultsHeader on:click={addAttachment} />
  <Results {attachments} />
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
