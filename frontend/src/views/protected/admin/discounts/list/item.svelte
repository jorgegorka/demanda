<script>
  import { createEventDispatcher } from "svelte";

  import { formatDate } from "../../../../../lib/utils/dates";

  export let discount = {};

  const dispatch = createEventDispatcher();

  function discountFigure() {
    return discount.percentage > 0
      ? `${discount.percentage}%`
      : discount.amount;
  }
</script>

<tr class="even:bg-gray-100 text-gray-700">
  <td class="py-3 pl-4">
    <a class="text-link" href={`/admin/discounts/show/${discount.id}`}>
      {discount.name}
    </a>
  </td>
  <td class="py-3 text-right">{discountFigure()}</td>
  <td class="py-3 text-right">{formatDate(discount.startAt)}</td>
  <td class="py-3 text-right">
    {discount.endAt ? formatDate(discount.endAt) : 'No end date'}
  </td>
  <td class="py-3 text-right">{discount.active}</td>
  <td class="py-3 pr-4 text-right">
    <a href={`/admin/discounts/edit/${discount.id}`}>
      <i class="material-icons text-blue-500">edit</i>
    </a>
    <a
      href="#!"
      class="ml-2"
      on:click={() => dispatch('removeDiscount', discount.id)}>
      <i class="material-icons text-red-600">delete</i>
    </a>
  </td>
</tr>
