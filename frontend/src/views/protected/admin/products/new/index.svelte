<script>
  import { navigateTo } from "svelte-router-spa";

  import Loading from "../../../../components/loading.svelte";
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import ProductsForm from "../form/index.svelte";
  import { ProductModel } from "../../../../../lib/models/product";
  import { CategoryModel } from "../../../../../lib/models/category";

  export let currentRoute;
  export let params;

  const categoriesList = CategoryModel().find({ all: true });

  let productModel = ProductModel({
    name: "",
    categoryId: "",
    price: 0.0,
    stock: 0,
  });
  let disableAction = false;

  function addProduct(event) {
    disableAction = true;
    if (productModel.valid()) {
      productModel.add().then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/products/show/${result.product.id}`);
        }
      });
    } else {
      disableAction = false;
      productModel = { ...productModel };
    }
  }
</script>

<PageHeader title="New product" />

{#await $categoriesList}
  <Loading />
{:then result}
  <ProductsForm
    product={productModel}
    categories={result.data.categories}
    submitText="Create product"
    on:submit={addProduct}
    {disableAction} />
{:catch error}
  Error: {error}
{/await}
