import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import {
  addUser,
  deleteUser,
  listUsers,
  showUser,
  updateUser,
} from "../queries/users";
import { Request } from "../queries/request";

function UserQuery() {
  function add(userInfo) {
    return Request.mutation(
      graphqlClient,
      "createUser",
      {
        mutation: addUser,
        variables: { userInfo },
      },
      { success: "User created successfully" }
    );
  }

  function edit(userInfo) {
    return Request.mutation(
      graphqlClient,
      "updateUser",
      {
        mutation: updateUser,
        variables: { userInfo },
      },
      { success: "User updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listUsers,
      variables: params,
    });
  }

  function findOne(userId) {
    return query(graphqlClient, {
      query: showUser,
      variables: { id: userId },
    });
  }

  function remove(userId) {
    const userInfo = { id: userId };
    return Request.mutation(
      graphqlClient,
      "deleteUser",
      {
        mutation: deleteUser,
        variables: { userInfo },
      },
      { success: "User deleted successfully" }
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

export { UserQuery };
