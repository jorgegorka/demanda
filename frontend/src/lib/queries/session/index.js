import gql from "graphql-tag";

const createSession = gql`
  mutation Signup($signupInfo: SignupInput!) {
    signup(input: $signupInfo) {
      token
      errors
    }
  }
`;

const newSession = gql`
  mutation Login($loginInfo: LoginUserInput!) {
    login(input: $loginInfo) {
      token
      errors
    }
  }
`;

export { createSession, newSession };
