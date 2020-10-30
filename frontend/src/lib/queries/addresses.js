import gql from "graphql-tag";

const listAddresses = gql`
  query Addresses($id: String) {
    addresses(id: $id) {
      id
      name
      firstAddress
      postalCode
      city
    }
  }
`;

const showAddress = gql`
  query ShowAddress($id: String) {
    addresses(id: $id) {
      id
      name
      firstAddress
      secondAddress
      postalCode
      city
      country
    }
  }
`;

const addAddress = gql`
  mutation CreateAddress($addressInfo: CreateAddressInput!) {
    createAddress(input: $addressInfo) {
      address {
        id
        name
      }
      errors
    }
  }
`;

const deleteAddress = gql`
  mutation DeleteAddress($addressInfo: DeleteAddressInput!) {
    deleteAddress(input: $addressInfo) {
      errors
      message
    }
  }
`;

const updateAddress = gql`
  mutation UpdateAddress($addressInfo: UpdateAddressInput!) {
    updateAddress(input: $addressInfo) {
      address {
        id
      }
      errors
    }
  }
`;

export { addAddress, deleteAddress, listAddresses, showAddress, updateAddress };
