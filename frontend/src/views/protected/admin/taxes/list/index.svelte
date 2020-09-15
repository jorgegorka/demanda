<script>
  import Loading from "../../../../components/loading.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import TaxResults from "./results.svelte";
  import { TaxModel } from "../../../../../lib/models/tax";

  const listParams = {};

  const taxesList = TaxModel().find(listParams);

  function deleteTax(event) {
    TaxModel()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          taxesList.refetch();
        }
      });
  }
</script>

{#await $taxesList}
  <Loading />
{:then result}
  {#if result.data.taxes.length > 0}
    <TaxResults taxes={result.data.taxes} on:deleteTax={deleteTax} />
  {:else}
    <Alert
      message="There are no taxes"
      extraInfo="What a day, you can create the first tax ever!" />
  {/if}
{:catch error}
  Error: {error}
{/await}
