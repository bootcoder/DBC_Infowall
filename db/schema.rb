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

ActiveRecord::Schema.define(version: 20160808075647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "organizer"
    t.string   "location"
    t.string   "img_url"
    t.string   "event_url"
    t.string   "attending"
    t.string   "event_type"
    t.text     "description"
    t.datetime "schedule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "calendar_id"
  end

  create_table "marquees", force: :cascade do |t|
    t.string   "text"
    t.string   "text_color",     default: "black"
    t.string   "bg_color",       default: "white"
    t.string   "display_status", default: "none"
    t.integer  "scroll_amount",  default: 10
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "mentors", force: :cascade do |t|
    t.string   "name"
    t.string   "img_url"
    t.string   "phase"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "staff_type"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "phase"
    t.string   "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "staff_type"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
