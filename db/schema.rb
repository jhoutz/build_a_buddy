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

ActiveRecord::Schema.define(version: 2019_06_07_134103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_products", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "product_type"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_products_on_item_id"
    t.index ["product_type", "product_id"], name: "index_item_products_on_product_type_and_product_id"
  end

  create_table "stuffed_animal_accessories", force: :cascade do |t|
    t.bigint "stuffed_animal_id"
    t.bigint "accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_stuffed_animal_accessories_on_accessory_id"
    t.index ["stuffed_animal_id"], name: "index_stuffed_animal_accessories_on_stuffed_animal_id"
  end

  create_table "stuffed_animals", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "stuffed_animal_accessories", "accessories"
  add_foreign_key "stuffed_animal_accessories", "stuffed_animals"
end
