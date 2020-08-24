<script>
  import { navigateTo } from "svelte-router-spa";

  import Loading from "../../../../components/loading.svelte";
  import PageHeader from "../../../../components/protected/page_header.svelte";
  import ProductsForm from "../form/index.svelte";
  import { ProductModel } from "../../../../../lib/models/product";
  import { CategoryModel } from "../../../../../lib/models/category";

  export let product = {};

  let disableAction = false;
  let productModel = ProductModel(product);
  const categoriesList = CategoryModel().find({ all: true });

  function editProduct() {
    disableAction = true;
    if (productModel.valid()) {
      productModel.edit(product.id).then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/products/show/${product.id}`);
        }
      });
    } else {
      productModel = { ...productModel };
    }
  }
</script>

<PageHeader title={product.name} />

{#await $categoriesList}
  <Loading />
{:then result}
  <ProductsForm
    product={productModel}
    categories={result.data.categories}
    submitText="Edit product"
    on:submit={editProduct}
    {disableAction} />
{:catch error}
  Error: {error}
{/await}
