<script>
  import { createEventDispatcher } from "svelte";

  import Loading from "../loading.svelte";

  export let cancelText = "Cancel";
  export let cancelButton = true;
  export let submitText = "Submit";
  export let isLoading = false;

  const dispatch = createEventDispatcher();

  function cancelAction(event) {
    event.preventDefault();
    dispatch("cancel");
  }
</script>

<div class="mt-4 flex justify-end pt-2">
  {#if cancelButton}
    <button type="button" on:click={cancelAction} class="btn-flat-cancel mr-2">{cancelText}</button>
  {/if}
  {#if isLoading}
    <Loading />
  {:else}
    <button type="submit" class="btn-success">{submitText}</button>
  {/if}
</div>
