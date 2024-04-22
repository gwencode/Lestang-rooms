# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_22_205029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "arrival"
    t.datetime "departure"
    t.integer "guests_number"
    t.integer "booking_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "night_price"
    t.integer "nights"
    t.string "duration"
    t.integer "reduction", default: 0
    t.integer "cleaning_fee", default: 0
    t.text "comment", default: ""
    t.boolean "paid", default: false
    t.string "checkout_session_id"
    t.boolean "refund", default: false
    t.integer "refund_amount"
    t.float "bank_fees", default: 0.0
    t.float "total_price", default: 0.0
    t.integer "caution", default: 0
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_id", null: false
    t.index ["booking_id"], name: "index_chatrooms_on_booking_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.string "author"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reviews_on_room_id"
  end

  create_table "room_prices", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.integer "night_price"
    t.integer "medium_guests", default: 0
    t.integer "night_price_medium_guests", default: 0
    t.integer "high_guests", default: 0
    t.integer "night_price_high_guests", default: 0
    t.integer "week_duration", default: 7
    t.integer "week_reduction"
    t.integer "medium_duration", default: 15
    t.integer "medium_reduction"
    t.integer "high_duration", default: 28
    t.integer "high_reduction"
    t.integer "small_cleaning_duration", default: 2
    t.integer "small_cleaning_fee", default: 0
    t.integer "medium_cleaning_duration", default: 3
    t.integer "medium_cleaning_fee", default: 0
    t.integer "high_cleaning_duration", default: 7
    t.integer "high_cleaning_fee", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_prices_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "max_guests"
    t.string "arrival_hour"
    t.string "departure_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bedrooms"
    t.integer "beds"
    t.integer "bathrooms"
    t.integer "min_nights"
    t.integer "max_nights"
    t.integer "available_days", default: 0
    t.boolean "default_available_slots", default: false
    t.string "slug"
    t.float "bank_fees", default: 0.0
    t.integer "caution", default: 0
    t.index ["slug"], name: "index_rooms_on_slug", unique: true
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "min_nights"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_seasons_on_room_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "available", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "airbnb_booking", default: false
    t.index ["room_id"], name: "index_slots_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "chatrooms", "bookings"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "rooms"
  add_foreign_key "room_prices", "rooms"
  add_foreign_key "seasons", "rooms"
  add_foreign_key "slots", "rooms"
end
