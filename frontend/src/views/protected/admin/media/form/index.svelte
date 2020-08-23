<script>
  import Loading from "../../../../components/loading.svelte";
  import FormFields from "./fields.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";

  export let attachment;

  let languages = LanguageModel().find($apolloClient, {});
</script>

{#await $languages}
  <Loading />
{:then result}
  <FormFields languages={result.data.languages} {attachment} />
{:catch error}
  Error: {error}
{/await}
