import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { deleteComment, listComments, showComment, updateComment } from "../queries/comments";
import { Request } from "../queries/request";

class Comments {
  static edit(commentInfo) {
    return Request.mutation(
      graphqlClient,
      "updateComment",
      {
        mutation: updateComment,
        variables: { commentInfo },
      },
      { success: "Comment updated successfully" }
    );
  }

  static find(params) {
    return query(graphqlClient, {
      query: listComments,
      variables: params,
    });
  }

  static findOne(commentId) {
    return query(graphqlClient, {
      query: showComment,
      variables: { id: commentId },
    });
  }

  static remove(commentId) {
    const commentInfo = { id: commentId };
    return Request.mutation(
      graphqlClient,
      "deleteComment",
      {
        mutation: deleteComment,
        variables: { commentInfo },
      },
      { success: "Comment deleted successfully" }
    );
  }
}

export { Comments };
