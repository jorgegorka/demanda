<script>
  // import Loading from "../../../../components/loading.svelte";
  // import CategoryResults from "./results.svelte";
  // import { CategoryModel } from "../../../../../lib/models/category";

  const listParams = {};

  // const categoriesList = CategoryModel().find(listParams);

  // function deleteCategory(event) {
  //   CategoryModel()
  //     .remove(event.detail)
  //     .then(function (result) {
  //       if (result.errors.length === 0) {
  //         categoriesList.refetch();
  //       }
  //     });
  // }
</script>

<!-- {#await $categoriesList}
  <Loading />
{:then result}
  <CategoryResults categories={result.data.categories} on:deleteCategory={deleteCategory} />
{:catch error}
  Error: {error}
{/await} -->
