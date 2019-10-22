<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TaxesForm from "../form/index.svelte";
  import { Taxes } from "../../../../../lib/database/taxes";
  import { TaxModel } from "../../../../../lib/models/taxes";

  export let tax = {};
  export let categories = [];
  export let graphqlClient;

  let disableAction = false;
  const taxModel = TaxModel(tax);

  function editTax(event) {
    disableAction = true;
    const taxInfo = {
      name: event.detail.name,
      id: tax.id
    };
    Taxes(graphqlClient)
      .edit(taxInfo)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/taxes/show/${tax.id}`);
        }
      });
  }
</script>

<PageHeader title={tax.name} />

<TaxesForm
  tax={taxModel}
  {categories}
  submitText="Edit tax"
  on:validInfo={editTax}
  {disableAction} />
