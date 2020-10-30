<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import AddressForm from "../form/index.svelte";
  import { Address } from "../../../../../lib/models/address";

  export let address = {};

  let disableAction = false;
  let addressModel = Address(address);

  function editAddress() {
    disableAction = true;
    if (addressModel.valid()) {
      addressModel.edit(address.id).then(function (result) {
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

<PageHeader title={address.name || 'Address'} />

<AddressForm
  address={addressModel}
  submitText="Edit address"
  on:submit={editAddress}
  {disableAction} />
