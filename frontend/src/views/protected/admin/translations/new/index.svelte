<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TranslationsForm from "../form/index.svelte";
  import { TranslationModel } from "../../../../../lib/models/translation";

  export let currentRoute;
  export let params;

  let translationModel = TranslationModel({
    name: "",
    parentId: currentRoute.namedParams.parentId
  });
  let disableAction = false;

  function addTranslation() {
    disableAction = true;
    if (translationModel.valid()) {
      translationModel.add(params.graphqlClient).then(function() {
        disableAction = false;
      });
    } else {
      disableAction = false;
      translationModel = { ...translationModel };
    }
  }
</script>

<TranslationsForm
  translation={translationModel}
  submitText="Create translation"
  on:submit={addTranslation}
  {disableAction} />
