import gql from "graphql-tag";

const listOrders = gql`
  query Orders($id: String, $status: String) {
    orders(id: $id, status: $status) {
      id
      status
      total
      totalPaid
      createdAt
      updatedAt
      orderItems {
        totalGross
        totalDiscount
        totalNet
        totalTax
        total
        product {
          name
          mainImageThumbUrl
        }
      }
    }
  }
`;

const showOrder = gql`
  query ShowOrder($id: String, $status: String) {
    orders(id: $id, name: $name) {
      id
      status
      total
      createdAt
    }
  }
`;

const addOrder = gql`
  mutation CreateOrder($orderInfo: CreateOrderInput!) {
    createOrder(input: $orderInfo) {
      order {
        id
      }
      errors
    }
  }
`;

const deleteOrder = gql`
  mutation DeleteOrder($orderInfo: DeleteOrderInput!) {
    deleteOrder(input: $orderInfo) {
      errors
    }
  }
`;

const updateOrder = gql`
  mutation UpdateOrder($orderInfo: UpdateOrderInput!) {
    updateOrder(input: $orderInfo) {
      order {
        id
        status
      }
      errors
    }
  }
`;

export { addOrder, deleteOrder, listOrders, showOrder, updateOrder };
