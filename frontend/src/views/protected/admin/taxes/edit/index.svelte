<script>
  import ShowTax from "./tax.svelte";
  import TaxFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: taxId = currentRoute.namedParams.id;
</script>

<TaxFinder show={false} {taxId} graphqlClient={params.graphqlClient} />
