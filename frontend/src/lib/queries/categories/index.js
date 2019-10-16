import gql from "graphql-tag";

const listCategories = gql`
  query {
    categories {
      id
      name
      childrenCount
    }
  }
`;

const showCategory = gql`
  query {
    categories {
      id
      name
      childrenCount
      children {
        id
        name
        childrenCount
      }
      translations {
        language
        name
        description
      }
    }
  }
`;

const addCategory = gql`
  mutation CreateCategory($categoryInfo: CreateCategoryInput!) {
    createCategory(input: $categoryInfo) {
      id
      name
      childrenCount
    }
  }
`;

export { listCategories, showCategory, addCategory };
