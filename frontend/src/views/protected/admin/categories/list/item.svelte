<script>
  import { createEventDispatcher } from "svelte";

  export let category = {};

  const dispatch = createEventDispatcher();

  function removeCategory() {
    dispatch("removeCategory", category.id);
  }
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/categories/show/${category.id}`}>
      {category.name}
    </a>
  </td>
  <td class="py-3 text-right">{category.childrenCount}</td>
  <td class="py-3 pr-4 text-right">
    <a href={`/admin/categories/edit/${category.id}`}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a href="#!" class="ml-2" on:click={removeCategory}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
