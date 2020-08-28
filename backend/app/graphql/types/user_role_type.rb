# frozen_string_literal: true

module Types
  class UserRoleType < Types::BaseEnum
    value 'Customer', value: :customer
    value 'Admin', value: :admin
    value 'Manager', value: :manager
  end
end
