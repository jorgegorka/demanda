import gql from "graphql-tag";

const listComments = gql`
  query Comments($id: String, $approved: Boolean) {
    comments(id: $id, approved: $approved) {
      id
      description
      approved
      createdAt
      replyDescription
      repliedAt
      customer {
        name
      }
    }
  }
`;

const showComment = gql`
  query ShowComment($id: String, $approved: String) {
    comments(id: $id, approved: $approved) {
      id
      description
      approved
      createdAt
      replyDescription
      repliedAt
      customer {
        name
      }
    }
  }
`;

const deleteComment = gql`
  mutation DeleteComment($commentInfo: DeleteCommentInput!) {
    deleteComment(input: $commentInfo) {
      errors
      message
    }
  }
`;

const updateComment = gql`
  mutation UpdateComment($commentInfo: UpdateCommentInput!) {
    updateComment(input: $commentInfo) {
      id
      description
      approved
      createdAt
      replyDescription
      repliedAt
      customer {
        name
      }
      errors
    }
  }
`;

export { deleteComment, listComments, showComment, updateComment };
