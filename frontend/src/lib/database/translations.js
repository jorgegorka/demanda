import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import {
  addTranslation,
  deleteTranslation,
  listTranslations,
  showTranslation,
  updateTranslation,
} from "../queries/translations";
import { Request } from "../queries/request";

function Translations() {
  function add(translationInfo) {
    return Request.mutation(
      graphqlClient,
      "createTranslation",
      {
        mutation: addTranslation,
        variables: { translationInfo },
      },
      { success: "Translation created successfully" }
    );
  }

  function edit(translationInfo) {
    return Request.mutation(
      graphqlClient,
      "updateTranslation",
      {
        mutation: updateTranslation,
        variables: { translationInfo },
      },
      { success: "Translation updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listTranslations,
      variables: params,
    });
  }

  function findOne(translationId) {
    return query(graphqlClient, {
      query: showTranslation,
      variables: { id: translationId },
    });
  }

  function remove(translationInfo) {
    return Request.mutation(
      graphqlClient,
      "deleteTranslation",
      {
        mutation: deleteTranslation,
        variables: { translationInfo },
      },
      { success: "Translation deleted successfully" }
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

export { Translations };
