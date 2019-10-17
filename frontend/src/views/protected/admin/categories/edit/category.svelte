<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import CategoriesForm from "../form/index.svelte";
  import { apolloClient } from "../../../../../lib/stores/apollo_client";
  import { Categories } from "../../../../../lib/database/categories";

  export let category = {};

  let disableAction = false;
  let formFields = {
    name: {
      value: category.name,
      error: false,
      message: ""
    },
    parentId: {
      value: category.parent ? category.parent.id : null
    }
  };

  function editCategory(event) {
    disableAction = true;
    const categoryInfo = {
      name: event.detail.name,
      id: category.id
    };
    Categories($apolloClient)
      .edit(categoryInfo)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/categories/show/${category.id}`);
        }
      });
  }
</script>

<PageHeader title={category.name} />

<CategoriesForm
  {formFields}
  submitText="Edit category"
  on:validInfo={editCategory}
  {disableAction} />
