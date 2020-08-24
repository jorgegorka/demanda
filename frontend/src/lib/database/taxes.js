import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { addTax, deleteTax, listTaxes, showTax, updateTax } from "../queries/taxes";
import { Request } from "../queries/request";

function Taxes() {
  function add(taxInfo) {
    return Request.mutation(
      graphqlClient,
      "createTax",
      {
        mutation: addTax,
        variables: { taxInfo },
      },
      { success: "Tax created successfully" }
    );
  }

  function edit(taxInfo) {
    return Request.mutation(
      graphqlClient,
      "updateTax",
      {
        mutation: updateTax,
        variables: { taxInfo },
      },
      { success: "Tax updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listTaxes,
      variables: params,
    });
  }

  function findOne(taxId) {
    return query(graphqlClient, {
      query: showTax,
      variables: { id: taxId },
    });
  }

  function remove(taxId) {
    const taxInfo = { id: taxId };
    return Request.mutation(
      graphqlClient,
      "deleteTax",
      {
        mutation: deleteTax,
        variables: { taxInfo },
      },
      { success: "Tax deleted successfully" }
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

export { Taxes };
