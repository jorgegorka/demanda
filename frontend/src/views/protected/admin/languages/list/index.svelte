<script>
  import Loading from "../../../../components/loading.svelte";
  import LanguageResults from "./results.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";

  const listParams = {};

  const languagesList = LanguageModel().find(listParams);

  function deleteLanguage(event) {
    LanguageModel()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          languagesList.refetch();
        }
      });
  }
</script>

{#await $languagesList}
  <Loading />
{:then result}
  <LanguageResults languages={result.data.languages} on:deleteLanguage={deleteLanguage} />
{:catch error}
  Error: {error}
{/await}
