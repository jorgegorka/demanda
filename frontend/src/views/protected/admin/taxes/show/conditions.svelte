<script>
  export let conditions = [];
</script>

{#if conditions.length > 0}
  {#each conditions as condition}
    <p class="mt-1">{condition}</p>
  {/each}
{:else}
  <p class="mt-2">This tax will be applied to all orders.</p>
{/if}
