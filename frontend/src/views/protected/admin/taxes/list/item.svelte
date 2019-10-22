<script>
  import { createEventDispatcher } from "svelte";

  import { formatDate } from "../../../../../lib/utils/dates";

  export let tax = {};

  const dispatch = createEventDispatcher();

  function taxFigure() {
    return tax.percentage > 0 ? `${tax.percentage}%` : tax.amount;
  }
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/taxes/show/${tax.id}`}>{tax.name}</a>
  </td>
  <td class="py-3 text-right">{taxFigure()}</td>
  <td class="py-3 text-right">{formatDate(tax.startAt)}</td>
  <td class="py-3 text-right">
    {tax.endAt ? formatDate(tax.endAt) : 'No end date'}
  </td>
  <td class="py-3 text-right">{tax.active}</td>
  <td class="py-3 pr-4 text-right">
    <a href={`/admin/taxes/edit/${tax.id}`}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a href="#!" class="ml-2" on:click={() => dispatch('removeTax', tax.id)}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
