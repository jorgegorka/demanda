import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { addProduct, deleteProduct, listProducts, showProduct, updateProduct } from "../queries/products";
import { Request } from "../queries/request";

function Products() {
  function add(productInfo) {
    return Request.mutation(
      graphqlClient,
      "createProduct",
      {
        mutation: addProduct,
        variables: { productInfo },
      },
      { success: "Product created successfully" }
    );
  }

  function edit(productInfo) {
    return Request.mutation(
      graphqlClient,
      "updateProduct",
      {
        mutation: updateProduct,
        variables: { productInfo },
      },
      { success: "Product updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listProducts,
      variables: params,
    });
  }

  function findOne(productId) {
    return query(graphqlClient, {
      query: showProduct,
      variables: { id: productId },
    });
  }

  function remove(productId) {
    const productInfo = { id: productId };
    return Request.mutation(
      graphqlClient,
      "deleteProduct",
      {
        mutation: deleteProduct,
        variables: { productInfo },
      },
      { success: "Product deleted successfully" }
    );
  }

  return Object.freeze({
    add,
    edit,
    find,
    findOne,
    remove,
  });
}

export { Products };
