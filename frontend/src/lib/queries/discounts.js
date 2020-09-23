import gql from "graphql-tag";

const listDiscounts = gql`
  query Discounts($id: String, $name: String) {
    discounts(id: $id, name: $name) {
      id
      name
      active
      amount
      percentage
      startAt
      endAt
    }
  }
`;

const showDiscount = gql`
  query ShowDiscount($id: String, $name: String) {
    discounts(id: $id, name: $name) {
      id
      name
      active
      amount
      percentage
      startAt
      endAt
      minimumQuantity
      minimumPrice
      userId
      categoryId
      productId
      product {
        id
        name
      }
      category {
        id
        name
      }
      user {
        id
        name
      }
    }
    categories {
      id
      name
    }
  }
`;

const addDiscount = gql`
  mutation CreateDiscount($discountInfo: CreateDiscountInput!) {
    createDiscount(input: $discountInfo) {
      discount {
        id
        name
      }
      errors
    }
  }
`;

const deleteDiscount = gql`
  mutation DeleteDiscount($discountInfo: DeleteDiscountInput!) {
    deleteDiscount(input: $discountInfo) {
      errors
      message
    }
  }
`;

const updateDiscount = gql`
  mutation UpdateDiscount($discountInfo: UpdateDiscountInput!) {
    updateDiscount(input: $discountInfo) {
      discount {
        id
        name
        active
        amount
        percentage
        startAt
        endAt
        minimumPrice
        minimumQuantity
        userId
        categoryId
        productId
        product {
          id
          name
        }
        category {
          id
          name
        }
        user {
          id
          name
        }
      }
      errors
    }
  }
`;

export {
  addDiscount,
  deleteDiscount,
  listDiscounts,
  showDiscount,
  updateDiscount,
};
