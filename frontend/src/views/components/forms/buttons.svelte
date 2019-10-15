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

<style>
  .form-buttons {
    display: flex;
    justify-content: flex-end;
  }
  .cancel {
    margin-right: 1em;
  }
</style>

<div class="field form-buttons">
  {#if cancelButton}
    <button type="button" on:click={cancelAction} class="btn cancel btn-flat">
      {cancelText}
    </button>
  {/if}
  {#if isLoading}
    <Loading />
  {:else}
    <button type="submit" class="btn primary">{submitText}</button>
  {/if}
</div>
