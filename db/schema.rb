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

ActiveRecord::Schema.define(version: 20_190_609_194_038) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accessories', force: :cascade do |t|
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'item_products', force: :cascade do |t|
    t.integer 'item_id', null: false
    t.string 'product_type'
    t.bigint 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_item_products_on_item_id'
    t.index %w[product_type product_id], name: 'index_item_products_on_product_type_and_product_id'
  end

  create_table 'item_var_pairings', force: :cascade do |t|
    t.bigint 'item_variation_id'
    t.bigint 'compat_item_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['compat_item_id'], name: 'index_item_var_pairings_on_compat_item_id'
    t.index %w[item_variation_id compat_item_id], name: 'index_item_var_pairings_on_item_variation_id_and_compat_item_id', unique: true
    t.index ['item_variation_id'], name: 'index_item_var_pairings_on_item_variation_id'
  end

  create_table 'item_variations', force: :cascade do |t|
    t.bigint 'item_id'
    t.bigint 'item_product_id'
    t.bigint 'size_id'
    t.integer 'quantity'
    t.float 'cost'
    t.float 'sale_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_item_variations_on_item_id'
    t.index ['item_product_id'], name: 'index_item_variations_on_item_product_id'
    t.index ['size_id'], name: 'index_item_variations_on_size_id'
  end

  create_table 'items', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'purchase_order_items', force: :cascade do |t|
    t.bigint 'purchase_order_id'
    t.bigint 'item_variation_id'
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_variation_id'], name: 'index_purchase_order_items_on_item_variation_id'
    t.index ['purchase_order_id'], name: 'index_purchase_order_items_on_purchase_order_id'
  end

  create_table 'purchase_orders', force: :cascade do |t|
    t.datetime 'order_datetime'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'sizes', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'stuffed_animals', force: :cascade do |t|
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'item_var_pairings', 'item_variations'
  add_foreign_key 'item_var_pairings', 'item_variations', column: 'compat_item_id'
  add_foreign_key 'item_variations', 'item_products'
  add_foreign_key 'item_variations', 'items'
  add_foreign_key 'item_variations', 'sizes'
  add_foreign_key 'purchase_order_items', 'item_variations'
  add_foreign_key 'purchase_order_items', 'purchase_orders'
end
