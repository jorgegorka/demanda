import { ApolloClient } from "apollo-client";
import { InMemoryCache } from "apollo-cache-inmemory";
import { setContext } from "apollo-link-context";
import { HttpLink } from "apollo-link-http";

import { SessionToken } from "../session/token";

const cache = new InMemoryCache();
const httpLink = new HttpLink({
  uri: "http://localhost:2603/graphql",
});

const authLink = setContext(function (_, { headers }) {
  // get the authentication token from local storage if it exists
  const token = SessionToken.find();
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : "",
    },
  };
});

const client = new ApolloClient({ link: authLink.concat(httpLink), cache });

export { client };
