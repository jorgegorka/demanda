<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import TranslationsForm from "../form/index.svelte";
  import { TranslationModel } from "../../../../../lib/models/translation";

  export let parent = {};
  export let translation = {};
  export let showModal = false;

  const dispatch = createEventDispatcher();

  let disableAction = false;
  let translationModel = TranslationModel({
    name: translation.name,
    description: translation.description,
    languageId: translation.language.id,
    parentId: parent.id,
    parentType: parent.type,
  });

  function closeModal() {
    disableAction = false;
    dispatch("updateTranslation");
  }

  function addTranslation() {
    disableAction = true;

    if (translationModel.valid()) {
      translationModel.edit(translation.id).then(() => closeModal());
    } else {
      disableAction = false;
      translationModel = { ...translationModel };
    }
  }
</script>

<Modal
  {showModal}
  title={`Editing translation for ${parent.name}`}
  {disableAction}
  on:confirmModal={addTranslation}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText={'Update translation'}>
  <TranslationsForm translation={translationModel} />
</Modal>
