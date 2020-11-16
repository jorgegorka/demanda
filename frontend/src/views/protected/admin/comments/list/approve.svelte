<script>
  import { createEventDispatcher } from "svelte";
  export let comment = {};

  const dispatch = createEventDispatcher();
</script>

{#if !comment.approved}
  <span class="inline-flex rounded-md shadow-sm">
    <button
      on:click={() => dispatch('approveComment', comment.id)}
      type="button"
      class="inline-flex items-center px-2.5 py-1.5 border border-green-300 text-xs leading-4 font-medium rounded text-green-700 bg-white hover:text-green-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-green-800 active:bg-green-50 transition ease-in-out duration-150">
      Approve
    </button>
  </span>
{/if}
