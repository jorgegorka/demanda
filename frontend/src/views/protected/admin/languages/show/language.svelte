<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import LanguageResults from "../results.svelte";
  import Translations from "../../../../components/protected/translations/index.svelte";

  export let language = {};

  function deleteLanguage(event) {
    Languages()
      .remove(event.detail)
      .then(function () {
        languagesList.refetch();
      });
  }
</script>

<PageHeader title={language.name}>
  <div class="flex items-center">
    <a href={`/admin/languages/edit/${language.id}`} class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit language
    </a>
  </div>
</PageHeader>
