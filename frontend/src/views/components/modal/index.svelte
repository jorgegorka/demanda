<script>
  import { createEventDispatcher } from "svelte";

  import Loading from "../loading.svelte";

  export let showModal = false;
  export let showCancelButton = true;
  export let disableAction = false;
  export let title = "";
  export let cancelText = "Cancel";
  export let confirmText = "Submit";

  const dispatch = createEventDispatcher();

  function closeModal() {
    dispatch("closeModal");
  }
</script>

{#if showModal}
  <div
    class="absolute w-full h-100 inset-0 z-20"
    style="background: rgba(0,0,0,.7);"
    on:click={closeModal} />
  <div
    class="relative bg-white w-11/12 md:max-w-xl lg:max-w-3xl mx-auto rounded
    shadow-lg z-50 overflow-y-auto">
    <div class="modal-content py-4 text-left px-6">
      <div class="flex justify-between items-center pb-3">
        <p class="text-2xl font-bold">{title}</p>
        <div class="cursor-pointer z-50" on:click={closeModal}>
          <svg
            class="fill-current text-black"
            xmlns="http://www.w3.org/2000/svg"
            width="18"
            height="18"
            viewBox="0 0 18 18">
            <path
              d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47
              4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z" />
          </svg>
        </div>
      </div>
      <div class="my-5">
        <slot />
      </div>
      <div class="flex justify-end pt-2">
        {#if showCancelButton}
          <button
            type="button"
            class="btn flat-cancel mr-2"
            on:click={() => dispatch('cancelModal')}>
            {cancelText}
          </button>
        {/if}
        {#if disableAction}
          <Loading />
        {:else}
          <button
            type="button"
            class="btn success"
            on:click={() => dispatch('confirmModal')}>
            {confirmText}
          </button>
        {/if}

      </div>
    </div>
  </div>
{/if}
