<script>
  import Loading from "../../../../components/loading.svelte";
  import AddressResults from "./results.svelte";
  import { Address } from "../../../../../lib/models/address";

  const listParams = {};

  const addressesList = Address().find(listParams);

  function deleteAddress(event) {
    Address()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          addressesList.refetch();
        }
      });
  }
</script>

{#await $addressesList}
  <Loading />
{:then result}
  <AddressResults
    addresses={result.data.addresses}
    on:deleteAddress={deleteAddress} />
{:catch error}
  Error:
  {error}
{/await}
