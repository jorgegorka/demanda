<script>
  import Loading from "../../../components/loading.svelte";
  import ShowProduct from "./show/product.svelte";
  import EditProduct from "./edit/product.svelte";
  import { ProductModel } from "../../../../lib/models/product";

  export let productId;
  export let graphqlClient;
  export let show = true;

  let product = ProductModel().findOne(graphqlClient, productId);

  function reload() {
    product.refetch();
  }
</script>

{#await $product}
  <Loading />
{:then result}
  {#if show}
    <ShowProduct
      product={result.data.products[0]}
      {graphqlClient}
      on:updateProduct={reload} />
  {:else}
    <EditProduct product={result.data.products[0]} {graphqlClient} />
  {/if}
{:catch error}
  Error: {error}
{/await}
