<script>
  import ShowTax from "./tax.svelte";
  import TaxFinder from "../finder.svelte";

  export let currentRoute;

  $: taxId = currentRoute.namedParams.id;
</script>

<TaxFinder show={false} {taxId} />
