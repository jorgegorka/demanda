import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { addCategory, deleteCategory, listCategories, showCategory, updateCategory } from "../queries/categories";
import { Request } from "../queries/request";

function Categories() {
  function add(categoryInfo) {
    return Request.mutation(
      graphqlClient,
      "createCategory",
      {
        mutation: addCategory,
        variables: { categoryInfo },
      },
      { success: "Category created successfully" }
    );
  }

  function edit(categoryInfo) {
    return Request.mutation(
      graphqlClient,
      "updateCategory",
      {
        mutation: updateCategory,
        variables: { categoryInfo },
      },
      { success: "Category updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listCategories,
      variables: params,
    });
  }

  function findOne(categoryId) {
    return query(graphqlClient, {
      query: showCategory,
      variables: { id: categoryId },
    });
  }

  function remove(categoryId) {
    const categoryInfo = { id: categoryId };
    return Request.mutation(
      graphqlClient,
      "deleteCategory",
      {
        mutation: deleteCategory,
        variables: { categoryInfo },
      },
      { success: "Category deleted successfully" }
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

export { Categories };
