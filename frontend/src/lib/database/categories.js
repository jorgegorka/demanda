import { query } from "svelte-apollo";

import {
  addCategory,
  listCategories,
  deleteCategory
} from "../queries/categories";
import { Request } from "../queries/request";

function Categories(graphqlClient) {
  function add(categoryInfo) {
    Request.mutation(
      graphqlClient,
      "createCategory",
      {
        mutation: addCategory,
        variables: { categoryInfo }
      },
      { success: "Category created successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listCategories,
      variables: params
    });
  }

  function remove(categoryId) {
    const categoryInfo = { id: categoryId };
    return Request.mutation(
      graphqlClient,
      "deleteCategory",
      {
        mutation: deleteCategory,
        variables: { categoryInfo }
      },
      { success: "Category deleted successfully" }
    );
  }

  return Object.freeze({
    add,
    find,
    remove
  });
}

export { Categories };
