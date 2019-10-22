<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { Taxes } from "../../../../lib/database/taxes";

  export let taxes;
  export let graphqlClient;

  function deleteTax(event) {
    Taxes(graphqlClient)
      .remove(event.detail)
      .then(function(result) {
        if (result.errors.length === 0) {
          taxes = taxes.filter(tax => tax.id !== event.detail);
        }
      });
  }
</script>

<ListResults {taxes} on:deleteTax={deleteTax} />
