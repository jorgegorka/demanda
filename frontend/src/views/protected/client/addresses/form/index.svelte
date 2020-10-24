<script>
  import Loading from "../../../../components/loading.svelte";
  import BasicFields from "./fields.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";
  import { CountryModel } from "../../../../../lib/models/country";
  import { countriesForSelect } from "../../../../../lib/utils/countries";

  const countriesList = CountryModel.find();

  export let address = {};
  export let submitText = "";
  export let disableAction = false;
</script>

{#await $countriesList}
  <Loading />
{:then result}
  <form class="p-4" ref="form" on:submit|preventDefault>
    <BasicFields
      {address}
      countries={countriesForSelect(result.data.countries)} />
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
{:catch error}
  Error:
  {error}
{/await}
