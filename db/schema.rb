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

ActiveRecord::Schema[7.0].define(version: 2023_04_28_150953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
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
    t.string "description"
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
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "reviews", "rooms"
  add_foreign_key "room_prices", "rooms"
end
