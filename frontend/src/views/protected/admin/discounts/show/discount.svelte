<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import DiscountConditions from "./conditions.svelte";
  import { formatDate } from "../../../../../lib/utils/dates";

  export let discount = {};

  let conditions = [];
  let anyConditions = priceConditions() || elementConditions();

  function deleteDiscount(event) {
    Discounts()
      .remove(event.detail)
      .then(function () {
        discountsList.refetch();
      });
  }

  function appliedDiscount() {
    if (discount.percentage) {
      return `by ${discount.percentage}%`;
    } else {
      return `adding ${discount.price}`;
    }
  }

  function disabledDate() {
    if (discount.endDate) {
      return `will be disabled on ${formatDate(discount.endDate)}`;
    } else {
      return "will remain enabled until you set a disabled date.";
    }
  }

  function priceConditions() {
    if (discount.minimumPrice > 0) {
      conditions.push(`Total order should be at least ${discount.minimumPrice}`);
    }
  }

  function elementConditions() {
    let text = "Discount will only be applied to orders";
    if (discount.user && discount.user.id) {
      conditions.push(`${text} from ${discount.user.name}`);
    }

    if (discount.category && discount.category.id) {
      conditions.push(`${text} with products included in the ${discount.category.name} category and its subcategories`);
    }

    if (discount.product && discount.product.id) {
      conditions.push(`${text} that include the product ${discount.product.name}`);
    }
  }
</script>

<PageHeader title={discount.name}>
  <div class="flex items-center">
    <a href={`/admin/discounts/edit/${discount.id}`} class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit discount
    </a>
  </div>
</PageHeader>

<div class="p-4 bg-white text-gray-900">
  <div class="flex justify-between items-center">
    <h3 class="text-lg font-display font-semibold">Details</h3>
    <span class="mr-4 px-3 py-1 bg-yellow-200 text-yellow-600 rounded-full border-yellow-500 border ">
      {discount.active ? 'Active' : 'Inactive'}
    </span>
  </div>
  <p class="mt-2">Discount will decrease the price {appliedDiscount()}</p>
  <p class="mt-1">Discount was enabled on {formatDate(discount.startAt)} and {disabledDate()}</p>
  <h3 class="mt-4 text-lg font-display font-semibold">Conditions</h3>
  <DiscountConditions {conditions} />
</div>
