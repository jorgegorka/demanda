<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import CategoriesForm from "../form/index.svelte";
  import { CategoryModel } from "../../../../../lib/models/category";

  export let category = {};
  export let graphqlClient;

  let disableAction = false;
  let categoryModel = CategoryModel({
    name: category.name,
    parentId: category.parent ? category.parent.id : null
  });

  function editCategory() {
    disableAction = true;
    if (categoryModel.valid()) {
      categoryModel.edit(graphqlClient, category.id).then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/categories/show/${category.id}`);
        }
      });
    } else {
      categoryModel = { ...categoryModel };
    }
  }
</script>

<PageHeader title={category.name} />

<CategoriesForm
  category={categoryModel}
  submitText="Edit category"
  on:submit={editCategory}
  {disableAction} />
