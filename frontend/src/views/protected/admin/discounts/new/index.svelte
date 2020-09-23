<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import DiscountsForm from "../form/index.svelte";
  import { formatDate, inputDate } from "../../../../../lib/utils/dates";
  import { DiscountModel } from "../../../../../lib/models/discount";

  let discountModel = DiscountModel({
    name: "",
    active: true,
    percentage: 0.0,
    amount: 0,
    startAt: inputDate(new Date()),
    endAt: null,
    minimumPrice: 0,
    minimumQuantity: 0,
    userId: "",
    categoryId: "",
    productId: "",
  });
  let disableAction = false;

  function addDiscount(event) {
    disableAction = true;
    if (discountModel.valid()) {
      discountModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/discounts/show/${result.discount.id}`);
        }
      });
    } else {
      discountModel = { ...discountModel };
    }
  }
</script>

<PageHeader title="New discount" />

<DiscountsForm discount={discountModel} submitText="Create discount" on:submit={addDiscount} {disableAction} />
