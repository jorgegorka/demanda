<script>
  import CategoryItem from "./item.svelte";

  export let categories = [];
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Name</th>
      <th class="p-4 text-right">Subcategories</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each categories as category (category.id)}
      <CategoryItem {category} />
    {/each}
  </tbody>
</table>
