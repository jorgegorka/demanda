<script>
  import Loading from "../../../../components/loading.svelte";
  import ProductResults from "./results.svelte";
  import { ProductModel } from "../../../../../lib/models/product";

  const listParams = {};

  const productsList = ProductModel().find(listParams);

  function deleteProduct(event) {
    ProductModel()
      .remove(event.detail)
      .then(function (result) {
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
  Error:
  {error}
{/await}
