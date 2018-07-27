# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_26_052303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.boolean "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.bigint "user_id"
    t.index ["post_id"], name: "index_bookmarks_on_post_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.text "ISBN_10"
    t.text "ISBN_13"
    t.text "title"
    t.text "cover_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "self_link"
    t.decimal "list_price"
    t.text "description"
    t.text "publisher"
    t.text "subtitle"
    t.text "author"
    t.date "publication_date"
  end

  create_table "contracts", force: :cascade do |t|
    t.datetime "meeting_time"
    t.text "meeting_address_first"
    t.text "meeting_address_second"
    t.integer "final_payment_method"
    t.decimal "final_price"
    t.datetime "expiration_time"
    t.integer "status", default: 0
    t.bigint "seller_id"
    t.bigint "buyer_id"
    t.bigint "unsigned_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["buyer_id"], name: "index_contracts_on_buyer_id"
    t.index ["post_id"], name: "index_contracts_on_post_id"
    t.index ["seller_id"], name: "index_contracts_on_seller_id"
    t.index ["unsigned_user_id"], name: "index_contracts_on_unsigned_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.text "actual_product_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["post_id"], name: "index_messages_on_post_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contract_id"
    t.index ["contract_id"], name: "index_orders_on_contract_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "post_type"
    t.text "course_number"
    t.decimal "price"
    t.integer "condition", default: 0
    t.integer "payment_method", default: 0
    t.text "description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "book_id"
    t.bigint "user_id"
    t.integer "edition", default: 1
    t.index ["book_id"], name: "index_posts_on_book_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "major"
    t.string "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name"
    t.string "roles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "posts"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "contracts", "posts"
  add_foreign_key "contracts", "users", column: "buyer_id"
  add_foreign_key "contracts", "users", column: "seller_id"
  add_foreign_key "contracts", "users", column: "unsigned_user_id"
  add_foreign_key "images", "posts"
  add_foreign_key "messages", "posts"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "orders", "contracts"
  add_foreign_key "posts", "books"
  add_foreign_key "posts", "users"
end
