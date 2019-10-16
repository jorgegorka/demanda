<script>
  export let translation = {};
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">{translation.name}</td>
  <td class="py-3 text-right">{translation.description}</td>
  <td class="py-3 pr-4 text-right">
    <a href="#!">
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a href="#!" class="ml-2">
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
