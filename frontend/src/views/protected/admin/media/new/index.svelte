<script>
  import Modal from "../../../../components/modal/index.svelte";
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import AttachmentsForm from "../form/index.svelte";
  import { AttachmentModel } from "../../../../../lib/models/attachment";

  export let parent = {};
  export let showModal = false;

  let disableAction = false;
  let attachmentModel = AttachmentModel({
    title: "",
    languageId: "",
    parentId: parent.id,
    parentType: parent.type,
    files: [],
  });

  function closeModal() {
    showModal = false;
  }

  function addAttachment() {
    disableAction = true;
    if (attachmentModel.valid()) {
      attachmentModel.add().then(() => {
        closeModal();
        window.location.reload();
      });
    } else {
      disableAction = false;
      attachmentModel = { ...attachmentModel };
    }
  }
</script>

<Modal
  {showModal}
  title={`New media item for ${parent.name}`}
  {disableAction}
  on:confirmModal={addAttachment}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  confirmText={'Create media item'}>
  <AttachmentsForm attachment={attachmentModel} />
</Modal>
