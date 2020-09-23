import gql from "graphql-tag";

const listTaxes = gql`
  query Taxes($id: String, $name: String) {
    taxes(id: $id, name: $name) {
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

const showTax = gql`
  query ShowTax($id: String, $name: String) {
    taxes(id: $id, name: $name) {
      id
      name
      active
      amount
      percentage
      startAt
      endAt
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

const addTax = gql`
  mutation CreateTax($taxInfo: CreateTaxInput!) {
    createTax(input: $taxInfo) {
      tax {
        id
        name
      }
      errors
    }
  }
`;

const deleteTax = gql`
  mutation DeleteTax($taxInfo: DeleteTaxInput!) {
    deleteTax(input: $taxInfo) {
      errors
      message
    }
  }
`;

const updateTax = gql`
  mutation UpdateTax($taxInfo: UpdateTaxInput!) {
    updateTax(input: $taxInfo) {
      tax {
        id
        name
        active
        amount
        percentage
        startAt
        endAt
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
      errors
    }
  }
`;

export { addTax, deleteTax, listTaxes, showTax, updateTax };
