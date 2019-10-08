module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::Session::Signup
    field :login, mutation: Mutations::Session::Login
    field :create_category, mutation: Mutations::Category::Create
    field :update_category, mutation: Mutations::Category::Update
    field :delete_category, mutation: Mutations::Category::Delete
    field :create_customer, mutation: Mutations::Customer::Create
    field :update_customer, mutation: Mutations::Customer::Update
    field :delete_customer, mutation: Mutations::Customer::Delete
    field :create_tax, mutation: Mutations::Tax::Create
    field :update_tax, mutation: Mutations::Tax::Update
    field :delete_tax, mutation: Mutations::Tax::Delete
    field :create_discount, mutation: Mutations::Discount::Create
    field :update_discount, mutation: Mutations::Discount::Update
    field :delete_discount, mutation: Mutations::Discount::Delete
    field :create_coupon, mutation: Mutations::Coupon::Create
    field :update_coupon, mutation: Mutations::Coupon::Update
    field :delete_coupon, mutation: Mutations::Coupon::Delete
  end
end
