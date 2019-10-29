<script>
  import Loading from "../../../../components/loading.svelte";
  import ProductResults from "./results.svelte";
  import { ProductModel } from "../../../../../lib/models/product";

  export let parentId;
  export let graphqlClient;

  const listParams = {};

  const productsList = ProductModel().find(graphqlClient, listParams);

  function deleteProduct(event) {
    ProductModel()
      .remove(graphqlClient, event.detail)
      .then(function(result) {
        if (result.errors.length === 0) {
          productsList.refetch();
        }
      });
  }
</script>

{#await $productsList}
  <Loading />
{:then result}
  <ProductResults
    products={result.data.products}
    on:deleteProduct={deleteProduct} />
{:catch error}
  Error: {error}
{/await}
