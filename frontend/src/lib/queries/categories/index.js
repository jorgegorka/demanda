import gql from "graphql-tag";

const listCategories = gql`
  query {
    categories {
      id
      name
      translations {
        name
        language
      }
    }
  }
`;

export { listCategories };
