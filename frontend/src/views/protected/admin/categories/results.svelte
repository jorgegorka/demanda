<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { Categories } from "../../../../lib/database/categories";

  export let categories;

  function deleteCategory(event) {
    Categories()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          categories = categories.filter((category) => category.id !== event.detail);
        }
      });
  }
</script>

<ListResults {categories} on:deleteCategory={deleteCategory} />
