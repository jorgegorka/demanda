<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import DiscountsForm from "../form/index.svelte";
  import { Discounts } from "../../../../../lib/database/discounts";
  import { DiscountModel } from "../../../../../lib/models/discounts";

  export let discount = {};
  export let categories = [];
  export let graphqlClient;

  let disableAction = false;
  const discountModel = DiscountModel(discount);

  function editDiscount(event) {
    disableAction = true;
    const discountInfo = { ...event.detail, id: discount.id };
    Discounts(graphqlClient)
      .edit(discountInfo)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/discounts/show/${discount.id}`);
        }
      });
  }
</script>

<PageHeader title={discount.name} />

<DiscountsForm
  discount={discountModel}
  {categories}
  submitText="Edit discount"
  on:validInfo={editDiscount}
  {disableAction} />
