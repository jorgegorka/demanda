<script>
  import AddressFinder from "../finder.svelte";

  export let currentRoute;

  $: addressId = currentRoute.namedParams.id;
</script>

<AddressFinder show={false} {addressId} />
