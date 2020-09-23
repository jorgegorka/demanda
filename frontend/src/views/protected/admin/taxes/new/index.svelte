<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TaxesForm from "../form/index.svelte";
  import { formatDate, inputDate } from "../../../../../lib/utils/dates";
  import { TaxModel } from "../../../../../lib/models/tax";

  let taxModel = TaxModel({
    name: "",
    active: true,
    percentage: 0.0,
    amount: 0,
    startAt: inputDate(new Date()),
    endAt: null,
    minimumPrice: 0,
    userId: "",
    categoryId: "",
    productId: "",
  });
  let disableAction = false;

  function addTax(event) {
    disableAction = true;
    if (taxModel.valid()) {
      taxModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/taxes/show/${result.tax.id}`);
        }
      });
    } else {
      taxModel = { ...taxModel };
    }
  }
</script>

<PageHeader title="New tax" />

<TaxesForm tax={taxModel} submitText="Create tax" on:submit={addTax} {disableAction} />
