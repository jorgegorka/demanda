import gql from "graphql-tag";

const listUsers = gql`
  query Users($id: String, $name: String) {
    users(id: $id, name: $name) {
      id
      name
      email
      phone
    }
  }
`;

const showUser = gql`
  query ShowUser($id: String, $name: String) {
    users(id: $id, name: $name) {
      id
      name
      email
      phone
      role
    }
  }
`;

const addUser = gql`
  mutation CreateUser($userInfo: CreateUserInput!) {
    createUser(input: $userInfo) {
      user {
        id
        name
        email
        phone
      }
      errors
    }
  }
`;

const deleteUser = gql`
  mutation DeleteUser($userInfo: DeleteUserInput!) {
    deleteUser(input: $userInfo) {
      errors
      message
    }
  }
`;

const updateUser = gql`
  mutation UpdateUser($userInfo: UpdateUserInput!) {
    updateUser(input: $userInfo) {
      user {
        id
        name
        email
        phone
      }
      errors
    }
  }
`;

export { addUser, deleteUser, listUsers, showUser, updateUser };
