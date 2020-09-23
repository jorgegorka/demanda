<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TaxConditions from "./conditions.svelte";
  import { formatDate } from "../../../../../lib/utils/dates";

  export let tax = {};

  let conditions = [];
  let anyConditions = priceConditions() || elementConditions();

  function deleteTax(event) {
    Taxes()
      .remove(event.detail)
      .then(function () {
        taxesList.refetch();
      });
  }

  function appliedTax() {
    if (tax.percentage) {
      return `by ${tax.percentage}%`;
    } else {
      return `adding ${tax.price}`;
    }
  }

  function disabledDate() {
    if (tax.endDate) {
      return `will be disabled on ${formatDate(tax.endDate)}`;
    } else {
      return "will remain enabled until you set a disabled date.";
    }
  }

  function priceConditions() {
    if (tax.minimumPrice > 0) {
      conditions.push(`Total order should be at least ${tax.minimumPrice}`);
    }
  }

  function elementConditions() {
    let text = "Tax will only be applied to orders";
    if (tax.user && tax.user.id) {
      conditions.push(`${text} from ${tax.user.name}`);
    }

    if (tax.category && tax.category.id) {
      conditions.push(`${text} with products included in the ${tax.category.name} category and its subcategories`);
    }

    if (tax.product && tax.product.id) {
      conditions.push(`${text} that include the product ${tax.product.name}`);
    }
  }
</script>

<PageHeader title={tax.name}>
  <div class="flex items-center">
    <a href={`/admin/taxes/edit/${tax.id}`} class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit tax
    </a>
  </div>
</PageHeader>

<div class="p-4 bg-white text-gray-900">
  <div class="flex justify-between items-center">
    <h3 class="text-lg font-display font-semibold">Details</h3>
    <span class="mr-4 px-3 py-1 bg-yellow-200 text-yellow-600 rounded-full border-yellow-500 border ">
      {tax.active ? 'Active' : 'Inactive'}
    </span>
  </div>
  <p class="mt-2">Tax will increase the price {appliedTax()}</p>
  <p class="mt-1">Tax was enabled on {formatDate(tax.startAt)} and {disabledDate()}</p>
  <h3 class="mt-4 text-lg font-display font-semibold">Conditions</h3>
  <TaxConditions {conditions} />
</div>
