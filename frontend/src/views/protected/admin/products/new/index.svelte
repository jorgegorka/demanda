<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import ProductsForm from "../form/index.svelte";
  import { Products } from "../../../../../lib/database/products";
  import { ProductModel } from "../../../../../lib/models/products";

  export let currentRoute;
  export let params;

  const productModel = ProductModel({
    name: "",
    parentId: currentRoute.namedParams.parentId
  });
  let disableAction = false;

  function addProduct(event) {
    disableAction = true;
    Products(params.graphqlClient)
      .add(event.detail)
      .then(function(result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/admin/products/show/${result.product.id}`);
        }
      });
  }
</script>

<PageHeader title="New product" />

<ProductsForm
  product={productModel}
  submitText="Create product"
  on:validInfo={addProduct}
  {disableAction} />
