<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { Categories } from "../../../../lib/database/categories";

  export let categories;
  export let graphqlClient;

  function deleteCategory(event) {
    console.log("here ", event.detail);
    Categories(graphqlClient)
      .remove(event.detail)
      .then(function(result) {
        if (result.errors.length === 0) {
          categories = categories.filter(
            category => category.id !== event.detail
          );
        }
      });
  }
</script>

<ListResults {categories} on:deleteCategory={deleteCategory} />
