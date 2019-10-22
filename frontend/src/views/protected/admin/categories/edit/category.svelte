<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import CategoriesForm from "../form/index.svelte";
  import { Categories } from "../../../../../lib/database/categories";
  import { CategoryModel } from "../../../../../lib/models/categories";

  export let category = {};
  export let graphqlClient;

  let disableAction = false;
  const categoryModel = CategoryModel({
    name: category.name,
    parentId: category.parent ? category.parent.id : null
  });

  function editCategory(event) {
    disableAction = true;
    const categoryInfo = {
      name: event.detail.name,
      id: category.id
    };
    Categories(graphqlClient)
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
  category={categoryModel}
  submitText="Edit category"
  on:validInfo={editCategory}
  {disableAction} />
