import gql from "graphql-tag";

const listCountries = gql`
  query Countries($id: String) {
    countries(id: $id) {
      id
      name
      translations
    }
  }
`;

const showCountry = gql`
  query ShowCountry($id: String) {
    countries(id: $id) {
      id
      name
      euMember
      continent
      translations
    }
  }
`;

export { listCountries, showCountry };
