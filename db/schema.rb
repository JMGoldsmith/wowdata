# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150216000006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auction_and_items", force: :cascade do |t|
    t.integer  "auc_item_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "auctions", force: :cascade do |t|
    t.integer  "auc"
    t.integer  "item_id"
    t.string   "owner"
    t.string   "ownerRealm"
    t.integer  "bid"
    t.integer  "buyout"
    t.integer  "quantity"
    t.string   "timeLeft"
    t.integer  "rand"
    t.integer  "seed"
    t.integer  "situation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "buyPrice"
    t.boolean  "equippable"
    t.integer  "item_id"
    t.string   "name"
    t.integer  "stackable"
    t.integer  "sellPrice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trades", force: :cascade do |t|
    t.string   "realm"
    t.string   "item"
    t.integer  "number_of_items"
    t.integer  "number_of_stacks"
    t.integer  "price_per_stack"
    t.integer  "price_per_item"
    t.string   "bnet_id"
    t.boolean  "cod"
    t.boolean  "order_filled"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "user_auctions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "auction"
    t.string   "owner"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "realm"
    t.string   "password"
    t.datetime "createdDate"
    t.datetime "lastLogin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
