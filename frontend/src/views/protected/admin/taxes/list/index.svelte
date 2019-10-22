<script>
  import Loading from "../../../../components/loading.svelte";
  import TaxResults from "./results.svelte";
  import { Taxes } from "../../../../../lib/database/taxes";

  export let graphqlClient;

  const listParams = {};

  const taxesList = Taxes(graphqlClient).find(listParams);

  function deleteTax(event) {
    Taxes(graphqlClient)
      .remove(event.detail)
      .then(function(result) {
        if (result.errors.length === 0) {
          taxesList.refetch();
        }
      });
  }
</script>

{#await $taxesList}
  <Loading />
{:then result}
  <TaxResults taxes={result.data.taxes} on:deleteTax={deleteTax} />
{:catch error}
  Error: {error}
{/await}
