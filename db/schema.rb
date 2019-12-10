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

  create_table "adoption_dates", force: :cascade do |t|
    t.date "date", null: false
  end

  create_table "standing_order_fragment_version_texts", force: :cascade do |t|
    t.string "text", limit: 2000, null: false
  end

  create_table "standing_order_fragment_versions", force: :cascade do |t|
    t.string  "text",                                    limit: 2000, null: false
    t.date    "adopted_on",                                           null: false
    t.string  "current_number",                          limit: 10,   null: false
    t.string  "standing_order_number",                   limit: 5
    t.integer "standing_order_number_in_list"
    t.string  "standing_order_letter_in_list",           limit: 1
    t.integer "fragment_number_in_list"
    t.integer "root_number",                                          null: false
    t.integer "reference",                                            null: false
    t.integer "year",                                                 null: false
    t.integer "adoption_date_id"
    t.integer "standing_order_fragment_id"
    t.integer "standing_order_fragment_version_text_id"
  end

  create_table "standing_order_fragments", force: :cascade do |t|
  end

  add_foreign_key "standing_order_fragment_versions", "adoption_dates", name: "fk_adoption_date"
  add_foreign_key "standing_order_fragment_versions", "standing_order_fragments", name: "fk_standing_order_fragment"
end
