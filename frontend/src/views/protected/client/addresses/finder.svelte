<script>
  import Loading from "../../../components/loading.svelte";
  import EditAddress from "./edit/address.svelte";
  import { Address } from "../../../../lib/models/address";

  export let addressId;

  let address = Address().findOne(addressId);
</script>

{#await $address}
  <Loading />
{:then result}
  <EditAddress address={result.data.addresses[0]} />
{:catch error}
  Error:
  {error}
{/await}
