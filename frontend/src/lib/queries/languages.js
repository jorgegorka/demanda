import gql from "graphql-tag";

const listLanguages = gql`
  query Languages($id: String) {
    languages(id: $id) {
      id
      name
      code
    }
  }
`;

const showLanguage = gql`
  query ShowLanguage($id: String, $name: String) {
    languages(id: $id, name: $name) {
      id
      name
      code
    }
  }
`;

const addLanguage = gql`
  mutation CreateLanguage($languageInfo: CreateLanguageInput!) {
    createLanguage(input: $languageInfo) {
      language {
        id
      }
      errors
    }
  }
`;

const deleteLanguage = gql`
  mutation DeleteLanguage($languageInfo: DeleteLanguageInput!) {
    deleteLanguage(input: $languageInfo) {
      errors
      message
    }
  }
`;

const updateLanguage = gql`
  mutation UpdateLanguage($languageInfo: UpdateLanguageInput!) {
    updateLanguage(input: $languageInfo) {
      language {
        id
      }
      errors
    }
  }
`;

export {
  addLanguage,
  deleteLanguage,
  listLanguages,
  showLanguage,
  updateLanguage,
};
