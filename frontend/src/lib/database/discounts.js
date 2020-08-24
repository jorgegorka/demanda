import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { addDiscount, deleteDiscount, listDiscounts, showDiscount, updateDiscount } from "../queries/discounts";
import { Request } from "../queries/request";

function Discounts() {
  function add(discountInfo) {
    return Request.mutation(
      graphqlClient,
      "createDiscount",
      {
        mutation: addDiscount,
        variables: { discountInfo },
      },
      { success: "Discount created successfully" }
    );
  }

  function edit(discountInfo) {
    return Request.mutation(
      graphqlClient,
      "updateDiscount",
      {
        mutation: updateDiscount,
        variables: { discountInfo },
      },
      { success: "Discount updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listDiscounts,
      variables: params,
    });
  }

  function findOne(discountId) {
    return query(graphqlClient, {
      query: showDiscount,
      variables: { id: discountId },
    });
  }

  function remove(discountId) {
    const discountInfo = { id: discountId };
    return Request.mutation(
      graphqlClient,
      "deleteDiscount",
      {
        mutation: deleteDiscount,
        variables: { discountInfo },
      },
      { success: "Discount deleted successfully" }
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

export { Discounts };
