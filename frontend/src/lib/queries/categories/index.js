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
      category {
        id
        name
        childrenCount
      }
      errors
    }
  }
`;

const deleteCategory = gql`
  mutation DeleteCategory($categoryInfo: DeleteCategoryInput!) {
    deleteCategory(input: $categoryInfo) {
      errors
      message
    }
  }
`;

export { addCategory, deleteCategory, listCategories, showCategory };
