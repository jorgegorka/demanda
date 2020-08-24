<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TaxesForm from "../form/index.svelte";
  import { TaxModel } from "../../../../../lib/models/tax";

  export let tax = {};
  export let categories = [];

  let disableAction = false;
  let taxModel = TaxModel(tax);

  function editTax(event) {
    disableAction = true;
    if (taxModel.valid()) {
      taxModel.edit(tax.id).then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/taxes/show/${tax.id}`);
        }
      });
    } else {
      taxModel = { ...taxModel };
    }
  }
</script>

<PageHeader title={tax.name} />

<TaxesForm tax={taxModel} {categories} submitText="Edit tax" on:submit={editTax} {disableAction} />
