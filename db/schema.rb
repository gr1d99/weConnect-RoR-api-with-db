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

ActiveRecord::Schema.define(version: 20180713065945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businesses_categories", id: false, force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "category_id", null: false
    t.index ["business_id", "category_id"], name: "index_businesses_categories_on_business_id_and_category_id"
    t.index ["category_id", "business_id"], name: "index_businesses_categories_on_category_id_and_business_id"
  end

  create_table "businesses_locations", id: false, force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "location_id", null: false
    t.index ["business_id", "location_id"], name: "index_businesses_locations_on_business_id_and_location_id"
    t.index ["location_id", "business_id"], name: "index_businesses_locations_on_location_id_and_business_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
