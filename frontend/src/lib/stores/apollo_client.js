import { writable } from "svelte/store";

const ApolloClient = writable({});

function set(content) {
  ApolloClient.set(content);
}

const apolloClient = {
  subscribe: ApolloClient.subscribe,
  set
};

export { apolloClient };
