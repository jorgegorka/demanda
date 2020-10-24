import { query } from "svelte-apollo";
import { client as graphqlClient } from "../config/apollo";

import { listCountries, showCountry } from "../queries/countries";

class Countries {
  static find(params) {
    return query(graphqlClient, {
      query: listCountries,
      variables: params,
    });
  }

  static findOne(countryId) {
    return query(graphqlClient, {
      query: showCountry,
      variables: { id: countryId },
    });
  }
}

export { Countries };
