# frozen_string_literal: true

class DemandaSchema < GraphQL::Schema
  mutation(Types::Mutation)
  query(Types::Query)
end
