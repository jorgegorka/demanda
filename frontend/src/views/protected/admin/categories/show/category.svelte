<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import CategoryResults from "../results.svelte";
  import Translations from "../../../../components/protected/translations/index.svelte";

  export let category = {};
  export let graphqlClient;

  const dispatch = createEventDispatcher();

  let showModal = false;
  let disableAction = false;
  let modalTitle = `New translation for ${category.name}`;
  let confirmText = "Create translation";
  let translationId = null;
  let translationModel = TranslationModel({
    name: "",
    description: "",
    languageId: "",
    parentId: category.id,
    parentType: "categories"
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

  function deleteCategory(event) {
    Categories(graphqlClient)
      .remove(event.detail)
      .then(function() {
        categoriesList.refetch();
      });
  }
</script>

<PageHeader title={category.name}>
  <div class="flex items-center">
    {#if category.parent}
      <a
        href={`/admin/categories/show/${category.parent.id}`}
        class="text-link mr-8">
        Back to {category.parent.name}
      </a>
    {/if}
    <a
      href="#!"
      on:click={() => (showModal = true)}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons ">add</i>
      Add Translation
    </a>
    <a
      href={`/admin/categories/new/${category.id}`}
      class="btn primary flex align-middle mr-8">
      <i class="material-icons ">add</i>
      Add children category
    </a>
    <a
      href={`/admin/categories/edit/${category.id}`}
      class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit category
    </a>
  </div>
</PageHeader>

{#if category.children.length > 0}
  <CategoryResults categories={category.children} {graphqlClient} />
{:else}
  <Alert message="This category has no children categories" />
{/if}

<div class="mt-4">
  {#if category.translations.length > 0}
    <Translations translations={category.translations} />
  {:else}
    <Alert message="This category has no translations available." />
  {/if}
</div>
