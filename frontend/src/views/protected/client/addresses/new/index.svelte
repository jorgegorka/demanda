<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import AddressesForm from "../form/index.svelte";
  import { Address } from "../../../../../lib/models/address";

  export let currentRoute;

  let addressModel = Address({
    name: "",
    parentId: currentRoute.namedParams.parentId,
    country: "ESP",
  });
  let disableAction = false;

  function addAddress() {
    disableAction = true;
    if (addressModel.valid()) {
      addressModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/user/addresses`);
        }
      });
    } else {
      addressModel = { ...addressModel };
    }
  }
</script>

<PageHeader title="New address" />

<AddressesForm
  address={addressModel}
  submitText="Create address"
  on:submit={addAddress}
  {disableAction} />
