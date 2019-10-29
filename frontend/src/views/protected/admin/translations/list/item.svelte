<script>
  import { createEventDispatcher } from "svelte";

  export let translation = {};

  const dispatch = createEventDispatcher();
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">{translation.name}</td>
  <td class="py-3 ">{translation.language.name}</td>
  <td class="py-3 pr-4 text-right">
    <a href="#!" on:click={() => dispatch('editTranslation', translation)}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a
      href="#!"
      class="ml-2"
      on:click={() => dispatch('removeTranslation', translation.id)}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
