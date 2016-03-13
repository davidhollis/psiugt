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

ActiveRecord::Schema.define(version: 20160313024750) do

  create_table "casein_admin_users", force: :cascade do |t|
    t.string   "login",                           null: false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        default: 0, null: false
    t.string   "crypted_password",                null: false
    t.string   "password_salt",                   null: false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         default: 0, null: false
    t.integer  "failed_login_count",  default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "initiation_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.integer  "status"
    t.integer  "initiation_class_id"
    t.integer  "big_brother_id"
    t.string   "member_attributes"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "members", ["big_brother_id"], name: "index_members_on_big_brother_id"
  add_index "members", ["initiation_class_id"], name: "index_members_on_initiation_class_id"

  create_table "menu_items", force: :cascade do |t|
    t.integer  "position"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "menu_items", ["page_id"], name: "index_menu_items_on_page_id"

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug",       null: false
    t.text     "body"
    t.text     "sidebar"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "published"
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
