<script>
  import { scale } from "svelte/transition";
  import { quintOut } from "svelte/easing";

  import { createEventDispatcher } from "svelte";

  import Loading from "../loading.svelte";

  export let showModal = false;
  export let showCancelButton = true;
  export let layerClosesForm = false;
  export let disableAction = false;
  export let title = "";
  export let cancelText = "Cancel";
  export let confirmText = "Submit";

  const dispatch = createEventDispatcher();

  function closeModal() {
    if (layerClosesForm) {
      dispatch("closeModal");
    }
  }
</script>

{#if showModal}
  <div
    in:scale={{ duration: 600, easing: quintOut }}
    out:scale={{ duration: 300, easing: quintOut }}
    class="fixed inset-0 flex justify-center items-center w-full h-full"
    style="background: rgba(0,0,0,.7);"
    on:click={closeModal}>
    <div
      class="bg-white w-11/12 md:max-w-xl lg:max-w-3xl mx-auto rounded shadow-lg"
      on:click={(e) => e.stopPropagation()}>
      <div class="modal-content py-4 text-left px-6">
        <div class="flex justify-between items-center pb-3">
          <p class="text-2xl font-bold">{title}</p>
          <div
            class="cursor-pointer z-50"
            on:click={() => dispatch('cancelModal')}>
            <svg
              class="fill-current text-black"
              xmlns="http://www.w3.org/2000/svg"
              width="18"
              height="18"
              viewBox="0 0 18 18">
              <path
                d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47
                1.06-1.06L10.06 9z" />
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
              class="btn-flat-cancel mr-2"
              on:click={() => dispatch('cancelModal')}>
              {cancelText}
            </button>
          {/if}
          {#if disableAction}
            <Loading />
          {:else}
            <button
              type="button"
              class="btn-success"
              on:click={() => dispatch('confirmModal')}>{confirmText}</button>
          {/if}
        </div>
      </div>
    </div>
  </div>
{/if}
