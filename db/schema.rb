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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_extents", force: :cascade do |t|
    t.string "label", limit: 20, null: false
  end

  create_table "fragment_versions", force: :cascade do |t|
    t.integer "revision_set_id",                         null: false
    t.integer "fragment_id"
    t.integer "order_id"
    t.integer "order_version_id"
    t.string  "parlrules_identifier",         limit: 20, null: false
    t.string  "current_number",               limit: 20, null: false
    t.string  "root_number",                  limit: 20, null: false
    t.text    "text",                                    null: false
    t.string  "parlrules_article_identifier", limit: 20, null: false
    t.string  "article_current_number",       limit: 20, null: false
    t.string  "article_root_number",          limit: 20, null: false
  end

  create_table "fragments", force: :cascade do |t|
    t.string "parlrules_identifier", limit: 20, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "order_versions", force: :cascade do |t|
    t.integer "revision_set_id",                 null: false
    t.integer "order_id"
    t.string  "parlrules_identifier", limit: 20, null: false
    t.string  "current_number",       limit: 20, null: false
    t.string  "root_number",          limit: 20, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string  "parlrules_identifier", limit: 20, null: false
    t.integer "business_extent_id",              null: false
    t.integer "house_id",                        null: false
  end

  create_table "revision_sets", force: :cascade do |t|
    t.date    "date",                                                                                          null: false
    t.integer "ordinality",                      default: "nextval('revision_sets_ordinality_seq'::regclass)", null: false
    t.string  "parlrules_identifier", limit: 20,                                                               null: false
    t.integer "business_extent_id",                                                                            null: false
    t.integer "house_id",                                                                                      null: false
  end

  create_table "revisions", force: :cascade do |t|
    t.integer "from_fragment_version_id",                 null: false
    t.integer "to_fragment_version_id",                   null: false
    t.boolean "is_major",                 default: false
  end

  add_foreign_key "fragment_versions", "fragments", name: "fk_fragment"
  add_foreign_key "fragment_versions", "order_versions", name: "fk_order_version"
  add_foreign_key "fragment_versions", "orders", name: "fk_order"
  add_foreign_key "fragment_versions", "revision_sets", name: "fk_revision_set"
  add_foreign_key "order_versions", "orders", name: "fk_order"
  add_foreign_key "order_versions", "revision_sets", name: "fk_revision_set"
  add_foreign_key "orders", "business_extents", name: "fk_business_extent"
  add_foreign_key "orders", "houses", name: "fk_house"
  add_foreign_key "revision_sets", "business_extents", name: "fk_business_extent"
  add_foreign_key "revision_sets", "houses", name: "fk_house"
end
