import gql from "graphql-tag";

const listComments = gql`
  query Comments($id: String, $approved: Boolean) {
    comments(id: $id, approved: $approved) {
      id
      description
      approved
      createdAt
      forName
      forId
      forType
      replyDescription
      repliedAt
      user {
        email
        name
      }
    }
  }
`;

const showComment = gql`
  query ShowComment($id: String) {
    comments(id: $id) {
      id
      description
      approved
      createdAt
      replyDescription
      repliedAt
      user {
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
      errors
      comment {
        id
      }
    }
  }
`;

export { deleteComment, listComments, showComment, updateComment };
