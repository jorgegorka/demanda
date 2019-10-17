<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import CategoriesForm from "../form/index.svelte";
  import { Categories } from "../../../../../lib/database/categories";
  import { CategoryModel } from "../../../../../lib/models/categories";

  export let currentRoute;
  export let params;

  const categoryModel = CategoryModel({
    name: "",
    parentId: currentRoute.namedParams.parentId
  });
  let disableAction = false;

  function addCategory(event) {
    disableAction = true;
    Categories(params.graphqlClient)
      .add(event.detail)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/categories/show/${result.category.id}`);
        }
      });
  }
</script>

<PageHeader title="New category" />

<CategoriesForm
  category={categoryModel}
  submitText="Create category"
  on:validInfo={addCategory}
  {disableAction} />
