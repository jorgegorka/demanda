<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import DiscountsForm from "../form/index.svelte";
  import { DiscountModel } from "../../../../../lib/models/discount";

  export let discount = {};
  export let categories = [];

  let disableAction = false;
  let discountModel = DiscountModel(discount);

  function editDiscount(event) {
    disableAction = true;
    if (discountModel.valid()) {
      discountModel.edit(discount.id).then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/discounts/show/${discount.id}`);
        }
      });
    } else {
      discountModel = { ...discountModel };
    }
  }
</script>

<PageHeader title={discount.name} />

<DiscountsForm
  discount={discountModel}
  {categories}
  submitText="Edit discount"
  on:submit={editDiscount}
  {disableAction} />
