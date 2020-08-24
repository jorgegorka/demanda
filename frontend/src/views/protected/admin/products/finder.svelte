<script>
  import Loading from "../../../components/loading.svelte";
  import ShowProduct from "./show/product.svelte";
  import EditProduct from "./edit/product.svelte";
  import { ProductModel } from "../../../../lib/models/product";

  export let productId;
  export let show = true;

  let product = ProductModel().findOne(productId);

  function reload() {
    product.refetch();
  }
</script>

{#await $product}
  <Loading />
{:then result}
  {#if show}
    <ShowProduct product={result.data.products[0]} on:updateProduct={reload} />
  {:else}
    <EditProduct product={result.data.products[0]} />
  {/if}
{:catch error}
  Error: {error}
{/await}
