import gql from "graphql-tag";

const listCategories = gql`
  query Categories($id: String, $name: String, $all: Boolean) {
    categories(id: $id, name: $name, all: $all) {
      id
      name
      childrenCount
    }
  }
`;

const showCategory = gql`
  query ShowCategory($id: String, $name: String) {
    categories(id: $id, name: $name) {
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

const addCategory = gql`
  mutation CreateCategory($categoryInfo: CreateCategoryInput!) {
    createCategory(input: $categoryInfo) {
      category {
        id
        name
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

const updateCategory = gql`
  mutation UpdateCategory($categoryInfo: UpdateCategoryInput!) {
    updateCategory(input: $categoryInfo) {
      category {
        id
      }
      errors
    }
  }
`;

export {
  addCategory,
  deleteCategory,
  listCategories,
  showCategory,
  updateCategory,
};
