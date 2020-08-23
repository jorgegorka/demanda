<script>
  import { createEventDispatcher } from "svelte";

  export let category = {};

  const dispatch = createEventDispatcher();
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/categories/show/${category.id}`}>{category.name}</a>
  </td>
  <td class="py-3 text-right">{category.childrenCount}</td>
  <td class="py-3 pr-4 text-right flex justify-evenly">
    <a href={`/admin/categories/edit/${category.id}`}>
      <svg viewBox="0 0 20 20" fill="currentColor" class="pencil w-6 h-6 text-blue-500">
        <path
          d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3
          14.172V17h2.828l8.38-8.379-2.83-2.828z" />
      </svg>
    </a>
    <a href="#!" class="ml-2" on:click={() => dispatch('removeCategory', category.id)}>
      <svg viewBox="0 0 20 20" fill="currentColor" class="trash w-6 h-6 text-red-500">
        <path
          fill-rule="evenodd"
          d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0
          100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1
          1 0 00-1-1z"
          clip-rule="evenodd" />
      </svg>
    </a>
  </td>
</tr>
