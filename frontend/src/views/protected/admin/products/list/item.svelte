<script>
  import { createEventDispatcher } from "svelte";

  export let product = {};

  const dispatch = createEventDispatcher();
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/products/show/${product.id}`}>
      {product.name}
    </a>
  </td>
  <td class="py-3 text-right">
    {product.category ? product.category.name : ''}
  </td>
  <td class="py-3 text-right">{product.price}</td>
  <td class="py-3 text-right">{product.stock}</td>
  <td class="py-3 pr-4 text-right">
    <a href={`/admin/products/edit/${product.id}`}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a
      href="#!"
      class="ml-2"
      on:click={() => dispatch('removeProduct', product.id)}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
