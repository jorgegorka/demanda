<script>
  import TaxFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: taxId = currentRoute.namedParams.id;
</script>

<TaxFinder {taxId} graphqlClient={params.graphqlClient} />
