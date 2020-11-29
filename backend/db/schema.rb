# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_27_193329) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", default: "", null: false
    t.string "domain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "default_language"
    t.index ["uuid"], name: "index_accounts_on_uuid"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "addressable_id"
    t.string "addressable_type"
    t.boolean "invoice", default: false
    t.string "name"
    t.string "label"
    t.string "vat_number"
    t.string "first_address", default: "", null: false
    t.string "second_address"
    t.string "postal_code"
    t.string "city", default: "", null: false
    t.string "state"
    t.string "country", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", limit: 36, null: false
    t.index ["addressable_id", "addressable_type", "invoice"], name: "address_and_invoice"
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type"
  end

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "language_id"
    t.integer "attachable_id"
    t.string "attachable_type"
    t.string "uuid", limit: 36, null: false
    t.string "title"
    t.integer "order", default: 999
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type"
    t.index ["language_id"], name: "index_attachments_on_language_id"
    t.index ["order"], name: "index_attachments_on_order"
    t.index ["uuid"], name: "index_attachments_on_uuid"
  end

  create_table "cart_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.integer "quantity_cents", default: 0, null: false
    t.string "quantity_currency", default: "EU2", null: false
    t.integer "total_tax_cents", default: 0, null: false
    t.string "total_tax_currency", default: "EU2", null: false
    t.integer "total_discount_cents", default: 0, null: false
    t.string "total_discount_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.string "uuid", limit: 36, null: false
    t.integer "total_tax_cents", default: 0, null: false
    t.string "total_tax_currency", default: "EU2", null: false
    t.integer "total_discount_cents", default: 0, null: false
    t.string "total_discount_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_carts_on_account_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
    t.index ["uuid"], name: "index_carts_on_uuid"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.bigint "account_id"
    t.integer "parent_id"
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["account_id", "slug"], name: "index_categories_on_account_id_and_slug"
    t.index ["account_id"], name: "index_categories_on_account_id"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["uuid"], name: "index_categories_on_uuid"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "commentable_type", default: "Product"
    t.bigint "commentable_id"
    t.bigint "account_id"
    t.bigint "user_id"
    t.bigint "language_id"
    t.string "uuid", limit: 36, null: false
    t.string "summary"
    t.text "description"
    t.decimal "rating", precision: 10
    t.boolean "featured", default: false
    t.boolean "verified_purchase", default: false
    t.boolean "approved", default: false
    t.text "reply_description"
    t.datetime "replied_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["commentable_id", "commentable_type", "approved", "language_id"], name: "comments_commentable_approved_language"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["featured", "created_at"], name: "index_comments_on_featured_and_created_at"
    t.index ["language_id"], name: "index_comments_on_language_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["uuid"], name: "index_comments_on_uuid"
  end

  create_table "gutentag_taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_gutentag_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id", "tag_id"], name: "unique_taggings", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_gutentag_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "gutentag_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0, null: false
    t.index ["name"], name: "index_gutentag_tags_on_name", unique: true
    t.index ["taggings_count"], name: "index_gutentag_tags_on_taggings_count"
  end

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.string "name"
    t.string "uuid", limit: 36, null: false
    t.string "code", limit: 6
    t.index ["account_id", "code"], name: "index_languages_on_account_id_and_code"
    t.index ["account_id", "name"], name: "index_languages_on_account_id_and_name", unique: true
    t.index ["account_id"], name: "index_languages_on_account_id"
    t.index ["uuid"], name: "index_languages_on_uuid"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.string "uuid", limit: 36, null: false
    t.boolean "price_includes_taxes"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EU2", null: false
    t.integer "quantity_cents", default: 0, null: false
    t.string "quantity_currency", default: "EU2", null: false
    t.integer "total_tax_cents", default: 0, null: false
    t.string "total_tax_currency", default: "EU2", null: false
    t.integer "total_discount_cents", default: 0, null: false
    t.string "total_discount_currency", default: "EU2", null: false
    t.string "user_reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["uuid"], name: "index_order_items_on_uuid"
  end

  create_table "order_price_modifiers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "order_item_id"
    t.bigint "product_id"
    t.bigint "category_id"
    t.bigint "user_id"
    t.bigint "price_modifier_id"
    t.string "name"
    t.string "uuid", limit: 36, null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EU2", null: false
    t.integer "percentage_cents", default: 0, null: false
    t.string "percentage_currency", default: "EU2", null: false
    t.integer "minimum_quantity_cents", default: 0, null: false
    t.string "minimum_quantity_currency", default: "EU2", null: false
    t.integer "minimum_price_cents", default: 0, null: false
    t.string "minimum_price_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_order_price_modifiers_on_category_id"
    t.index ["order_id"], name: "index_order_price_modifiers_on_order_id"
    t.index ["order_item_id"], name: "index_order_price_modifiers_on_order_item_id"
    t.index ["price_modifier_id"], name: "index_order_price_modifiers_on_price_modifier_id"
    t.index ["product_id"], name: "index_order_price_modifiers_on_product_id"
    t.index ["user_id"], name: "index_order_price_modifiers_on_user_id"
    t.index ["uuid"], name: "index_order_price_modifiers_on_uuid"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.bigint "invoice_id"
    t.bigint "coupon_id"
    t.string "uuid", limit: 36, null: false
    t.integer "status"
    t.string "user_reference"
    t.integer "total_tax_cents", default: 0, null: false
    t.string "total_tax_currency", default: "EU2", null: false
    t.integer "total_discount_cents", default: 0, null: false
    t.string "total_discount_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["invoice_id"], name: "index_orders_on_invoice_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["uuid"], name: "index_orders_on_uuid"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.string "uuid", limit: 36, null: false
    t.integer "origin"
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["uuid"], name: "index_payments_on_uuid"
  end

  create_table "price_modifiers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.bigint "account_id"
    t.bigint "product_id"
    t.bigint "category_id"
    t.bigint "user_id"
    t.string "uuid", limit: 36, null: false
    t.boolean "active", default: true
    t.boolean "single_use", default: false
    t.string "name"
    t.string "code", limit: 30
    t.integer "percentage_cents", default: 0, null: false
    t.string "percentage_currency", default: "EU2", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EU2", null: false
    t.timestamp "start_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "end_at"
    t.integer "minimum_quantity_cents", default: 0, null: false
    t.string "minimum_quantity_currency", default: "EU2", null: false
    t.integer "minimum_price_cents", default: 0, null: false
    t.string "minimum_price_currency", default: "EU2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "code"], name: "index_price_modifiers_on_account_id_and_code"
    t.index ["account_id"], name: "index_price_modifiers_on_account_id"
    t.index ["category_id"], name: "index_price_modifiers_on_category_id"
    t.index ["id", "type"], name: "index_price_modifiers_on_id_and_type"
    t.index ["product_id"], name: "index_price_modifiers_on_product_id"
    t.index ["user_id"], name: "index_price_modifiers_on_user_id"
    t.index ["uuid"], name: "index_price_modifiers_on_uuid"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "category_id"
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EU2", null: false
    t.boolean "price_includes_taxes", default: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "related_products"
    t.integer "rating", default: 0
    t.index ["account_id", "rating"], name: "index_products_on_account_id_and_rating"
    t.index ["account_id", "slug"], name: "index_products_on_account_id_and_slug"
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["uuid"], name: "index_products_on_uuid"
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_providers_on_account_id"
    t.index ["uuid"], name: "index_providers_on_uuid"
  end

  create_table "translations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "language_id"
    t.integer "translatable_id"
    t.string "uuid", limit: 36, null: false
    t.string "translatable_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["translatable_id", "translatable_type"], name: "index_translations_on_translatable_id_and_translatable_type"
    t.index ["uuid"], name: "index_translations_on_uuid"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "crypted_password"
    t.string "salt"
    t.string "uuid", limit: 36, null: false
    t.boolean "autogenerated", default: false
    t.bigint "account_id"
    t.bigint "language_id"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.integer "failed_logins_count", default: 0
    t.datetime "lock_expires_at"
    t.string "unlock_token"
    t.string "magic_login_token"
    t.datetime "magic_login_token_expires_at"
    t.datetime "magic_login_email_sent_at"
    t.string "phone"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email", "account_id"], name: "index_users_on_email_and_account_id", unique: true
    t.index ["language_id"], name: "index_users_on_language_id"
    t.index ["magic_login_token"], name: "index_users_on_magic_login_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
