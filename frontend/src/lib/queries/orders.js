import gql from "graphql-tag";

const listOrders = gql`
  query Orders($id: String, $status: String, $all: Boolean) {
    orders(id: $id, name: $name, all: $all) {
      id
      name
      childrenCount
    }
  }
`;

const showOrder = gql`
  query ShowOrder($id: String, $status: String) {
    orders(id: $id, name: $name) {
      id
      name
      slug
      childrenCount
      parent {
        id
        name
      }
      children {
        id
        name
        childrenCount
      }
      translations {
        id
        name
        description
        language {
          id
          name
        }
      }
      attachments {
        id
        title
        url
        order
        contentType
      }
    }
  }
`;

const addOrder = gql`
  mutation CreateOrder($orderInfo: CreateOrderInput!) {
    createOrder(input: $orderInfo) {
      order {
        id
        name
      }
      errors
    }
  }
`;

const deleteOrder = gql`
  mutation DeleteOrder($orderInfo: DeleteOrderInput!) {
    deleteOrder(input: $orderInfo) {
      errors
      message
    }
  }
`;

const updateOrder = gql`
  mutation UpdateOrder($orderInfo: UpdateOrderInput!) {
    updateOrder(input: $orderInfo) {
      order {
        id
      }
      errors
    }
  }
`;

export { addOrder, deleteOrder, listOrders, showOrder, updateOrder };
