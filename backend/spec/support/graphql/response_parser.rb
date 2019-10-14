module GraphQL
  module ResponseParser
    def parse_graphql_response(original_response)
      JSON.parse(original_response).delete('data')
    end
  end
end
