import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import {
  addAddress,
  deleteAddress,
  listAddresses,
  showAddress,
  updateAddress,
} from "../queries/addresses";
import { Request } from "../queries/request";

function AddressQuery() {
  function add(addressInfo) {
    return Request.mutation(
      graphqlClient,
      "createAddress",
      {
        mutation: addAddress,
        variables: { addressInfo },
      },
      { success: "Address created successfully" }
    );
  }

  function edit(addressInfo) {
    return Request.mutation(
      graphqlClient,
      "updateAddress",
      {
        mutation: updateAddress,
        variables: { addressInfo },
      },
      { success: "Address updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listAddresses,
      variables: params,
    });
  }

  function findOne(addressId) {
    return query(graphqlClient, {
      query: showAddress,
      variables: { id: addressId },
    });
  }

  function remove(addressId) {
    const addressInfo = { id: addressId };
    return Request.mutation(
      graphqlClient,
      "deleteAddress",
      {
        mutation: deleteAddress,
        variables: { addressInfo },
      },
      { success: "Address deleted successfully" }
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

export { AddressQuery };
