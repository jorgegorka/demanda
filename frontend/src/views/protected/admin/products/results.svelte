<script>
  import Loading from "../../../components/loading.svelte";
  import ListResults from "./list/results.svelte";
  import { ProductModel } from "../../../../lib/models/product";

  export let products;

  function deleteProduct(event) {
    ProductModel()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          products = products.filter((product) => product.id !== event.detail);
        }
      });
  }
</script>

<ListResults {products} on:deleteProduct={deleteProduct} />
