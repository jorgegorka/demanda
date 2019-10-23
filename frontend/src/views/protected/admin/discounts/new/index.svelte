<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import DiscountsForm from "../form/index.svelte";
  import { formatDate, inputDate } from "../../../../../lib/utils/dates";
  import { Discounts } from "../../../../../lib/database/discounts";
  import { DiscountModel } from "../../../../../lib/models/discounts";

  export let params;

  const discountModel = DiscountModel({
    name: "",
    active: true,
    percentage: 0.0,
    amount: 0,
    startAt: inputDate(new Date()),
    endAt: null,
    minimumPrice: 0,
    minimumQuantity: 0,
    customerId: "",
    categoryId: "",
    productId: ""
  });
  let disableAction = false;

  function addDiscount(event) {
    disableAction = true;
    Discounts(params.graphqlClient)
      .add(event.detail)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/discounts/show/${result.discount.id}`);
        }
      });
  }
</script>

<PageHeader title="New discount" />

<DiscountsForm
  discount={discountModel}
  submitText="Create discount"
  on:validInfo={addDiscount}
  {disableAction} />
