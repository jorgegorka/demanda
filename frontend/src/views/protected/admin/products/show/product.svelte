<script>
  import { createEventDispatcher } from "svelte";

  import Modal from "../../../../components/modal/index.svelte";
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import ProductResults from "../results.svelte";
  import ProductDetails from "./details.svelte";
  import TranslationResults from "../../translations/list/results.svelte";
  import TranslationsForm from "../../translations/form/index.svelte";
  import { TranslationModel } from "../../../../../lib/models/translation";
  import { ProductModel } from "../../../../../lib/models/product";

  export let product = {};
  export let graphqlClient;

  const dispatch = createEventDispatcher();

  let showModal = false;
  let disableAction = false;
  let modalTitle = `New translation for ${product.name}`;
  let confirmText = "Create translation";
  let translationId = null;
  let translationModel = TranslationModel({
    name: "",
    description: "",
    languageId: "",
    parentId: product.id,
    parentType: "products"
  });

  function closeModal() {
    showModal = false;
  }

  function openModal() {
    showModal = true;
    modalTitle = `New translation for ${product.name}`;
    confirmText = "Create translation";
    translationId = null;
  }

  function editTranslation(event) {
    translationModel = TranslationModel({
      name: event.detail.name,
      description: event.detail.description,
      languageId: event.detail.language.id,
      parentId: product.id,
      parentType: "products"
    });
    translationId = event.detail.id;
    modalTitle = `Edit translation for ${product.name}`;
    confirmText = "Edit translation";
    showModal = true;
  }

  function addTranslation() {
    disableAction = true;

    if (translationModel.valid()) {
      if (translationId) {
        translationModel
          .edit(graphqlClient, translationId)
          .then(function(result) {
            disableAction = false;
            dispatch("updateProduct");
            showModal = false;
          });
      } else {
        translationModel.add(graphqlClient).then(function(result) {
          disableAction = false;
          dispatch("updateProduct");
          showModal = false;
        });
      }
    } else {
      disableAction = false;
      translationModel = { ...translationModel };
    }
  }

  function deleteTranslation(event) {
    const translationInfo = {
      id: event.detail,
      parentType: "products",
      parentId: product.id
    };
    TranslationModel()
      .remove(graphqlClient, translationInfo)
      .then(function(result) {
        if (result.errors.length === 0) {
          product.translations = product.translations.filter(
            translation => translation.id !== translationInfo.id
          );
        }
      });
  }
</script>

<PageHeader title={product.name}>
  <div class="flex items-center">
    <a
      href="#!"
      on:click={() => (showModal = true)}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons text- ">add</i>
      Add Translation
    </a>
    <a
      href={`/admin/products/edit/${product.id}`}
      class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit product
    </a>
  </div>
</PageHeader>

<ProductDetails {product} />

<div class="mt-4">
  {#if product.translations.length > 0}
    <TranslationResults
      translations={product.translations}
      on:editTranslation={editTranslation}
      on:deleteTranslation={deleteTranslation} />
  {:else}
    <Alert message="This product has no translations available." />
  {/if}
</div>

<Modal
  {showModal}
  title={modalTitle}
  {disableAction}
  on:confirmModal={addTranslation}
  on:cancelModal={closeModal}
  on:closeModal={closeModal}
  {confirmText}>
  <TranslationsForm translation={translationModel} {graphqlClient} />
</Modal>
