<script>
  import Loading from "../../../../components/loading.svelte";
  import FormFields from "./fields.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";

  export let translation;

  let languages = LanguageModel().find({});
</script>

{#await $languages}
  <Loading />
{:then result}
  <FormFields languages={result.data.languages} {translation} />
{:catch error}
  Error: {error}
{/await}
