<script>
  import { createEventDispatcher } from "svelte";

  export let language = {};

  const dispatch = createEventDispatcher();
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/languages/show/${language.id}`}>
      {language.name}
    </a>
  </td>
  <td class="py-3 pr-4 text-right">
    <a href={`/admin/languages/edit/${language.id}`}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a
      href="#!"
      class="ml-2"
      on:click={() => dispatch('removeLanguage', language.id)}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
