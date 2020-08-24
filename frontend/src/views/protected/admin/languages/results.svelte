<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { Languages } from "../../../../lib/database/languages";

  export let languages;

  function deleteLanguage(event) {
    Languages()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          languages = languages.filter((language) => language.id !== event.detail);
        }
      });
  }
</script>

<ListResults {languages} on:deleteLanguage={deleteLanguage} />
