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

ActiveRecord::Schema.define(version: 20150210002410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auction_and_items", force: :cascade do |t|
    t.integer  "auc_item_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "auction_data", force: :cascade do |t|
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

  create_table "item_data", force: :cascade do |t|
    t.integer  "buyPrice"
    t.boolean  "equippable"
    t.integer  "item_id"
    t.string   "name"
    t.integer  "stackable"
    t.integer  "sellPrice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
