import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { addLanguage, deleteLanguage, listLanguages, showLanguage, updateLanguage } from "../queries/languages";
import { Request } from "../queries/request";

function Languages() {
  function add(languageInfo) {
    return Request.mutation(
      graphqlClient,
      "createLanguage",
      {
        mutation: addLanguage,
        variables: { languageInfo },
      },
      { success: "Language created successfully" }
    );
  }

  function edit(languageInfo) {
    return Request.mutation(
      graphqlClient,
      "updateLanguage",
      {
        mutation: updateLanguage,
        variables: { languageInfo },
      },
      { success: "Language updated successfully" }
    );
  }

  function find(params) {
    return query(graphqlClient, {
      query: listLanguages,
      variables: params,
    });
  }

  function findOne(languageId) {
    return query(graphqlClient, {
      query: showLanguage,
      variables: { id: languageId },
    });
  }

  function remove(languageId) {
    const languageInfo = { id: languageId };
    return Request.mutation(
      graphqlClient,
      "deleteLanguage",
      {
        mutation: deleteLanguage,
        variables: { languageInfo },
      },
      { success: "Language deleted successfully" }
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

export { Languages };
