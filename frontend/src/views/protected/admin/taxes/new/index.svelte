<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TaxesForm from "../form/index.svelte";
  import { formatDate, inputDate } from "../../../../../lib/utils/dates";
  import { Taxes } from "../../../../../lib/database/taxes";
  import { TaxModel } from "../../../../../lib/models/taxes";

  export let params;

  const taxModel = TaxModel({
    name: "",
    active: true,
    percentage: 0.0,
    amount: 0,
    startAt: inputDate(new Date()),
    endAt: null,
    minimumQuantity: 0,
    minimumPrice: 0,
    customer: "",
    category: "",
    product: ""
  });
  let disableAction = false;

  function addTax(event) {
    disableAction = true;
    Taxes(params.graphqlClient)
      .add(event.detail)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/taxes/show/${result.tax.id}`);
        }
      });
  }
</script>

<PageHeader title="New tax" />

<TaxesForm
  tax={taxModel}
  submitText="Create tax"
  on:validInfo={addTax}
  {disableAction} />
