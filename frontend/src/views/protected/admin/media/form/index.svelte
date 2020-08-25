<script>
  import Loading from "../../../../components/loading.svelte";
  import FormFields from "./fields.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";

  export let attachment;

  let languages = LanguageModel().find({});
</script>

{#await $languages}
  <Loading />
{:then result}
  <FormFields languages={result.data.languages} {attachment} />
{:catch error}
  Error: {error}
{/await}
