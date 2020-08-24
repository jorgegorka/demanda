<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import LanguagesForm from "../form/index.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";

  export let language = {};

  let disableAction = false;
  let languageModel = LanguageModel(language);

  function editLanguage() {
    disableAction = true;
    if (languageModel.valid()) {
      languageModel.edit(language.id).then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/languages/show/${language.id}`);
        }
      });
    } else {
      disableAction = false;
      languageModel = { ...languageModel };
    }
  }
</script>

<PageHeader title={language.name} />

<LanguagesForm language={languageModel} submitText="Edit language" on:submit={editLanguage} {disableAction} />
