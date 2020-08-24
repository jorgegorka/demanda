<script>
  import TaxFinder from "../finder.svelte";

  export let currentRoute;

  $: taxId = currentRoute.namedParams.id;
</script>

<TaxFinder {taxId} />
