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

  create_table "adoptions", force: :cascade do |t|
    t.date    "date",                                                                                      null: false
    t.integer "ordinality",                      default: "nextval('adoptions_ordinality_seq'::regclass)", null: false
    t.string  "parlrules_identifier", limit: 20,                                                           null: false
  end

  create_table "fragment_versions", force: :cascade do |t|
    t.integer "adoption_id",                             null: false
    t.integer "fragment_id"
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

  add_foreign_key "fragment_versions", "adoptions", name: "fk_adoption"
  add_foreign_key "fragment_versions", "fragments", name: "fk_fragment"
end
