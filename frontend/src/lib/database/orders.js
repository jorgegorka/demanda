import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import {
  addOrder,
  deleteOrder,
  listOrders,
  showOrder,
  updateOrder,
} from "../queries/orders";
import { Request } from "../queries/request";

function Orders() {
  function add(orderInfo) {
    return Request.mutation(
      graphqlClient,
      "createOrder",
      {
        mutation: addOrder,
        variables: { orderInfo },
      },
      { success: "Order created successfully" }
    );
  }

  function edit(orderInfo) {
    return Request.mutation(
      graphqlClient,
      "updateOrder",
      {
        mutation: updateOrder,
        variables: { orderInfo },
      },
      { success: "Order updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listOrders,
      variables: params,
    });
  }

  function findOne(orderId) {
    return query(graphqlClient, {
      query: showOrder,
      variables: { id: orderId },
    });
  }

  function remove(orderId) {
    const orderInfo = { id: orderId };
    return Request.mutation(
      graphqlClient,
      "deleteOrder",
      {
        mutation: deleteOrder,
        variables: { orderInfo },
      },
      { success: "Order deleted successfully" }
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

export { Orders };
