<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import LanguagesForm from "../form/index.svelte";
  import { LanguageModel } from "../../../../../lib/models/language";

  export let currentRoute;

  let languageModel = LanguageModel({
    name: "",
    code: "",
  });
  let disableAction = false;

  function addLanguage() {
    disableAction = true;
    if (languageModel.valid()) {
      languageModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/languages/show/${result.language.id}`);
        }
      });
    } else {
      languageModel = { ...languageModel };
    }
  }
</script>

<PageHeader title="New language" />

<LanguagesForm
  language={languageModel}
  submitText="Create language"
  on:submit={addLanguage}
  {disableAction} />
