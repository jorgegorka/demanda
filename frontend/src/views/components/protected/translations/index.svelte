<script>
  import TranslationItem from "./item.svelte";

  export let translations = [];
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Language</th>
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Description</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each translations as translation (translation.id)}
      <TranslationItem {translation} />
    {/each}
  </tbody>
</table>
