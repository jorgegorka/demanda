# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::Session::Signup
    field :login, mutation: Mutations::Session::Login
    field :create_category, mutation: Mutations::Category::Create
    field :update_category, mutation: Mutations::Category::Update
    field :delete_category, mutation: Mutations::Category::Delete
    field :create_user, mutation: Mutations::User::Create
    field :update_user, mutation: Mutations::User::Update
    field :delete_user, mutation: Mutations::User::Delete
    field :create_tax, mutation: Mutations::Tax::Create
    field :update_tax, mutation: Mutations::Tax::Update
    field :delete_tax, mutation: Mutations::Tax::Delete
    field :create_discount, mutation: Mutations::Discount::Create
    field :update_discount, mutation: Mutations::Discount::Update
    field :delete_discount, mutation: Mutations::Discount::Delete
    field :create_coupon, mutation: Mutations::Coupon::Create
    field :update_coupon, mutation: Mutations::Coupon::Update
    field :delete_coupon, mutation: Mutations::Coupon::Delete
    field :create_product, mutation: Mutations::Product::Create
    field :update_product, mutation: Mutations::Product::Update
    field :delete_product, mutation: Mutations::Product::Delete
    field :create_language, mutation: Mutations::Language::Create
    field :update_language, mutation: Mutations::Language::Update
    field :delete_language, mutation: Mutations::Language::Delete
    field :create_translation, mutation: Mutations::Translation::Create
    field :update_translation, mutation: Mutations::Translation::Update
    field :delete_translation, mutation: Mutations::Translation::Delete
    field :create_user, mutation: Mutations::User::Create
    field :update_user, mutation: Mutations::User::Update
    field :delete_user, mutation: Mutations::User::Delete
    field :update_cart, mutation: Mutations::Cart::Update
    field :create_comment, mutation: Mutations::Comment::Create
    field :update_comment, mutation: Mutations::Comment::Update
    field :delete_comment, mutation: Mutations::Comment::Delete
  end
end
