import gql from "graphql-tag";

const listTranslations = gql`
  query Translations($id: String) {
    translations(id: $id) {
      id
      name
      language {
        id
        name
      }
    }
  }
`;

const showTranslation = gql`
  query ShowTranslation($id: String, $name: String) {
    translations(id: $id, name: $name) {
      id
      name
      description
      language {
        id
        name
      }
    }
  }
`;

const addTranslation = gql`
  mutation CreateTranslation($translationInfo: CreateTranslationInput!) {
    createTranslation(input: $translationInfo) {
      translation {
        name
      }
      errors
    }
  }
`;

const deleteTranslation = gql`
  mutation DeleteTranslation($translationInfo: DeleteTranslationInput!) {
    deleteTranslation(input: $translationInfo) {
      errors
      message
    }
  }
`;

const updateTranslation = gql`
  mutation UpdateTranslation($translationInfo: UpdateTranslationInput!) {
    updateTranslation(input: $translationInfo) {
      translation {
        id
      }
      errors
    }
  }
`;

export {
  addTranslation,
  deleteTranslation,
  listTranslations,
  showTranslation,
  updateTranslation
};
