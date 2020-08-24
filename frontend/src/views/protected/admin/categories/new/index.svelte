<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import CategoriesForm from "../form/index.svelte";
  import { CategoryModel } from "../../../../../lib/models/category";

  export let currentRoute;

  let categoryModel = CategoryModel({
    name: "",
    parentId: currentRoute.namedParams.parentId,
  });
  let disableAction = false;

  function addCategory() {
    disableAction = true;
    if (categoryModel.valid()) {
      categoryModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/categories/show/${result.category.id}`);
        }
      });
    } else {
      categoryModel = { ...categoryModel };
    }
  }
</script>

<PageHeader title="New category" />

<CategoriesForm category={categoryModel} submitText="Create category" on:submit={addCategory} {disableAction} />
