import gql from "graphql-tag";

const listProducts = gql`
  query Products($id: String, $name: String, $categoryId: String) {
    products(id: $id, name: $name, categoryId: $categoryId) {
      id
      name
      price
      stock
      category {
        id
        name
      }
    }
  }
`;

const showProduct = gql`
  query ShowProduct($id: String, $name: String) {
    products(id: $id, name: $name) {
      id
      name
      price
      stock
      categoryId
      category {
        id
        name
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
    }
  }
`;

const addProduct = gql`
  mutation CreateProduct($productInfo: CreateProductInput!) {
    createProduct(input: $productInfo) {
      product {
        id
      }
      errors
    }
  }
`;

const deleteProduct = gql`
  mutation DeleteProduct($productInfo: DeleteProductInput!) {
    deleteProduct(input: $productInfo) {
      errors
      message
    }
  }
`;

const updateProduct = gql`
  mutation UpdateProduct($productInfo: UpdateProductInput!) {
    updateProduct(input: $productInfo) {
      product {
        id
      }
      errors
    }
  }
`;

export { addProduct, deleteProduct, listProducts, showProduct, updateProduct };
